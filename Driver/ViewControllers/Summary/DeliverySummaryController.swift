//
//  DeliverySummaryController.swift
//  Driver
//
//  Created by Zeeshan on 5/10/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import UIKit

class DeliverySummaryController:BaseController {
    
    //MARK: - Properties
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var receiptImageView: UIImageView!
    
    var receiptImage:UIImage!

    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTransparentNavBar()
        addBackButton(color: .white)
        addProfileButton()
        
        receiptImageView.image = receiptImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


//MARK: - Tap Handlers
extension DeliverySummaryController {
    
    @IBAction func didTapCompleteButton(){
        navigationController?.popToRootViewController(animated: true)
    }
}

