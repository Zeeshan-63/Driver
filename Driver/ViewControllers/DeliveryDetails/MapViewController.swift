//
//  MapViewController.swift
//  Driver
//
//  Created by Zeeshan on 5/8/19.
//  Copyright © 2019 Zeeshan. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomSheetView: UIView!
    @IBOutlet weak var navigatorButton: UIButton!
    @IBOutlet weak var bottomSheetTopConstraint: NSLayoutConstraint!
    
    
    var deliveryData:deliveryModel = deliveryModel()
    var destination:CLLocationCoordinate2D!
    var path:GMSPath?
    var marker:GMSMarker?
    var polyline:GMSPolyline?
    var index = 0
    var timer:Timer!
    
    //MARK: - Properties of BottomSheetView
    @IBOutlet weak var verificationTextLabel: UILabel!
    @IBOutlet weak var verifyButtonView: UIView!
    @IBOutlet var deliveryTypeLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    //MARK: - ViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        
        // This myLocation used for testing purpose instead of Current Location that will be get using CoreLocatation framework.
        let myLocation = CLLocationCoordinate2D(latitude: 33.548362, longitude: 73.055279)
        
        destination = CLLocationCoordinate2D(latitude: deliveryData.delivery_lat , longitude: deliveryData.delivery_long )
        
        fetchRoute(from: myLocation, to: destination)
        
        bottomSheetSetup()
        
        setupTransparentNavBar()
        addBackButton(color: .gray)
        addProfileButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bottomSheetTopConstraint.constant = -55
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Prevent a crash
        mapView = nil
        guard timer != nil else { return }
        timer.invalidate()
        timer = nil
    }
    
}

//MARK: - Utility Methods
extension MapViewController {
    
   func setupMapView() {
    let camera = GMSCameraPosition.camera(withLatitude: 33.548362, longitude: 73.055279, zoom: 13.0)
    mapView.camera = camera
    marker = GMSMarker()
    marker!.position = camera.target
    marker!.title = "Current Location"
    marker!.icon = UIImage(named: "current-loc")
    marker!.map = mapView
    
    showDestinationMarker(position: CLLocationCoordinate2D(latitude: deliveryData.delivery_lat , longitude: deliveryData.delivery_long))
    }
    
    func showDestinationMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Destination"
        marker.icon = UIImage(named: "destination")
        marker.map = mapView
    }
    
    //MARK:- Open Google Map in Browser
    func openTrackerInBrowser(){
        
            guard let lat = destination?.latitude, let longi = destination?.longitude else{
            return
            }
            
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination, options: [:], completionHandler: nil)
            }
    }
}

//MARK:- GoogleMap's directions API
extension MapViewController{
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let APIKey = "AIzaSyCEvGLLqxIjYhgKM3D4Dcp5KCByoylfYbc"
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(APIKey)")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any], let jsonResponse = jsonResult else {
                print("error in JSONSerialization")
                return
            }
            guard let routes = jsonResponse["routes"] as? [Any] else {
                return
            }
            print(jsonResponse)
            if let error_Message = jsonResponse["error_message"] as? String{
                Utility.instance.showAlert(title: "Alert", message: error_Message)
            }
            else{
                guard let route = routes[0] as? [String: Any] else {
                    return
                }
                
                guard let overview_polyline = route["overview_polyline"] as? [String: Any] else {
                    return
                }
                
                guard let polyLineString = overview_polyline["points"] as? String else {
                    return
                }
                
                //Call this method to draw path on map
                self.drawPath(from: polyLineString)
                
                //Call this method to move Marker on map
                self.moveMarker()
            }
        })
        task.resume()
    }
    
    // To draw polyline on map .
    func drawPath(from polyStr: String){
        path = GMSPath(fromEncodedPath: polyStr)
        polyline = GMSPolyline(path: path)
        polyline?.strokeWidth = 4.0
        polyline?.strokeColor = .black
        polyline?.map = mapView // Google MapView
    }
    
}

//MARK:- Move Marker on GoogleMap
extension MapViewController{
    func moveMarker() {
        guard timer == nil else { return }
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector:
                #selector(self.timerTriggered), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerTriggered() {
        
        if index < self.path!.count() {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.3)
            marker?.position = path!.coordinate(at:UInt(index))
            marker?.appearAnimation = .pop
            CATransaction.commit()
            self.index += 1
        } else {
            polyline?.map = nil
            didReachAtDestination()
            guard timer != nil else { return }
            timer.invalidate()
            timer = nil
        }
    }
    
    
}


//MARK: - Tap Handlers
extension MapViewController {
    
    @IBAction func didTapNavigationTrackerButton(){
        
        if let UrlNavigation = URL.init(string: "comgooglemaps://") {
            if UIApplication.shared.canOpenURL(UrlNavigation){
                guard let lat = destination?.latitude, let longi = destination?.longitude else{
                    return
                }
                    if let urlDestination = URL.init(string: "comgooglemaps://?saddr=&daddr=\(lat),\(longi)&directionsmode=driving") {
                        UIApplication.shared.open(urlDestination, options: [:], completionHandler: nil)
                    }
            }
            else {
                print("Can't use comgooglemaps://");
                self.openTrackerInBrowser()
            }
        }
        else
        {
            print("Can't use comgooglemaps://");
            self.openTrackerInBrowser()
        }
    }
}
