//
//  DeliveryDetailModel.swift
//  Driver
//
//  Created by Zeeshan on 5/11/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import Foundation


class deliveryModel{
    var customer:customerModel = customerModel()
    var delivery_Time:String = ""
    var delivery_lat:Double = 0.0
    var delivery_long:Double = 0.0
    var delivery_Type:deliveryType = .normal
    
    init(delivery_Type: deliveryType = .normal){
        customer = customerModel()
        delivery_Time = "12:54 am"
        delivery_lat = 33.572609 //33.570134
        delivery_long = 73.062615 //73.062375
        self.delivery_Type = delivery_Type
    }
}

class customerModel{
    var customer_Name:String = "John Doe"
    var customer_Address:String = "1114, Park Ave, St Paul"
    var image_URL:String = ""
    var customer_PhoneNumber:String = "03001234567"
}
