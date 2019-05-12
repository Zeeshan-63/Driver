//
//  DeliveryListController.swift
//  Driver
//
//  Created by Zeeshan on 5/7/19.
//  Copyright © 2019 Zeeshan. All rights reserved.
//

import UIKit

class DeliveryListController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var deliveryList = [deliveryModel]()
    
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTransparentNavBar()
        addProfileButton()
        
        setupTableView()
        setDummyData()
    }
}

//MARK: - Utility Methods
extension DeliveryListController {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight =  170
    }
    
    func setDummyData(){
        deliveryList = [deliveryModel(delivery_Type: .urgent), deliveryModel(), deliveryModel(), deliveryModel(delivery_Type: .urgent), deliveryModel(), deliveryModel()]
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension DeliveryListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DeliveryCell.cellForTableView(tableView, atIndexPath: indexPath)
        cell.setData(model: deliveryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "PENDING DELIVERIES"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .gray
            headerView.backgroundView?.backgroundColor = .white
        }
    }
    
}

//MARK: - UITableViewDelegate
extension DeliveryListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let controller = MapViewController(nibName: String.init(describing: MapViewController.self), bundle: .main)
        controller.deliveryData = deliveryList[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
