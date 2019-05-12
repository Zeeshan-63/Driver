//
//  CameraViewController.swift
//  Driver
//
//  Created by Zeeshan on 5/11/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var image:UIImage!
    
    var captureSession = AVCaptureSession()
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTransparentNavBar()
        addBackButton(color: .white)
        addProfileButton()
        
        cameraSetup()
        openCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession.stopRunning()
    }
}


//MARK: - Utility Methods
extension CameraViewController {
    
    func cameraSetup(){
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera,.builtInDualCamera,.builtInTelephotoCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        for device in (deviceSession.devices) {
            if device.position == AVCaptureDevice.Position.back {
                do {
                    let input = try AVCaptureDeviceInput(device: device)
                    
                    if captureSession.canAddInput(input){
                        captureSession.addInput(input)
                        
                        if captureSession.canAddOutput(sessionOutput){
                            captureSession.addOutput(sessionOutput)
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                            previewLayer.connection?.videoOrientation = .portrait
                            
                            view.layer.addSublayer(previewLayer)
                            view.bringSubview(toFront: captureButton)
                            view.bringSubview(toFront: galleryButton)
                            
                            previewLayer.frame = view.bounds
                        }
                    }
                    
                } catch let avError {
                    print(avError)
                }
            }
        }
    }
    
    func openCamera(){
        if PermissionHandler.instance.isPermissionAuthorizedforCamera(){
            captureSession.startRunning()
        }
        else{
            PermissionHandler.instance.requestCameraPermission(completion:
                { isPermissionOK in
                    if isPermissionOK
                    {
                        self.captureSession.startRunning()
                    }
            })
        }
    }
    
    func openGallery(){
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
}


//MARK: - AVCapturePhotoCaptureDelegate
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        let controller = DeliverySummaryController(nibName: String.init(describing: DeliverySummaryController.self), bundle: .main)
        controller.receiptImage = image
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}


//MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: {
            let controller = DeliverySummaryController(nibName: String.init(describing: DeliverySummaryController.self), bundle: .main)
                    controller.receiptImage = chosenImage
                    self.navigationController?.pushViewController(controller, animated: true)
        })
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - Tap Handlers
extension CameraViewController {
    
    @IBAction func didTapOnTakePhotoButton(_ sender: UIButton) {
        if PermissionHandler.instance.isPermissionAuthorizedforCamera(){
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            sessionOutput.capturePhoto(with: settings, delegate: self)
        }
        else{
            PermissionHandler.instance.requestCameraPermission(completion:
                { isPermissionOK in
                    if isPermissionOK
                    {
                        self.openCamera()
                    }
            })
        }
    }
    
    @IBAction func didTapOnGalleryButton(_ sender: UIButton) {
        
        if PermissionHandler.instance.isPermissionAuthorizedforPhotoLibrary(){
            openGallery()
        }
        else{
            PermissionHandler.instance.requestPhotoLibraryPermission(completion:
                { isPermissionOK in
                    if isPermissionOK
                    {
                        self.openGallery()
                    }
            })
        }
    }
}

