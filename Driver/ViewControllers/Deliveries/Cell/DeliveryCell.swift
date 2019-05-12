//
//  DeliveryCell.swift
//  Driver
//
//  Created by Zeeshan on 5/7/19.
//  Copyright © 2019 Zeeshan. All rights reserved.
//

import UIKit

class DeliveryCell: UITableViewCell {

    //MARK:- Properties
    static let identifier = "DeliveryCell"
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var deliveryTypeLabel: UILabel!
    
    @IBOutlet var bottomStackView: UIStackView!
    
    //MARK:- Cell Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.addShadow(radius: 10)
    }
}

//MARK: - Utility Methods
extension DeliveryCell{
    static func cellForTableView(_ tableView: UITableView, atIndexPath indexPath: IndexPath) -> DeliveryCell {
        tableView.register(UINib(nibName:"DeliveryCell", bundle: nil), forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DeliveryCell
        return cell
    }
    
    func setData(model:deliveryModel){
        nameLabel.text = model.customer.customer_Name
        addressLabel.text = model.customer.customer_Address
        deliveryTypeLabel.text = model.delivery_Type.rawValue == 0 ? "Normal" : "Urgent"
        timeLabel.text = model.delivery_Time
        bottomStackView.isHidden =  model.delivery_Type.rawValue == 0 ? true : false
    }
}
