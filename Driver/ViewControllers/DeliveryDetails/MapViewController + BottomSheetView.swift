//
//  MapViewController + BottomSheetView.swift
//  Driver
//
//  Created by Zeeshan on 5/11/19.
//  Copyright © 2019 ingic. All rights reserved.
//

import MessageUI


//MARK: - Utility Methods of BottomSheetView
extension MapViewController{
    
    func bottomSheetSetup(){
        bottomSheetTopConstraint.constant = -55
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        bottomSheetView.addGestureRecognizer(gesture)
        
        setBottomSheetData()
    }
    
    @objc func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let fullView: CGFloat = Constants.screenHeight - bottomSheetView.frame.size.height
        let partialView: CGFloat = Constants.screenHeight - 55
        let navigatorBtnX: CGFloat = bottomSheetView.frame.width - navigatorButton.frame.width - 15
        let navigatorBtnY: CGFloat = bottomSheetView.frame.minY - navigatorButton.frame.height - 10
        
        let translation = recognizer.translation(in: bottomSheetView)
        let velocity = recognizer.velocity(in: self.bottomSheetView)
        let y = self.bottomSheetView.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            bottomSheetView.frame = CGRect(x: 0, y: y + translation.y, width: Constants.screenWidth, height: bottomSheetView.frame.height)
            navigatorButton.frame = CGRect(x: navigatorBtnX, y: navigatorBtnY, width: navigatorButton.frame.width, height: navigatorButton.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.bottomSheetTopConstraint.constant = -55
                } else {
                    self.bottomSheetTopConstraint.constant = -self.bottomSheetView.frame.height
                }
            }, completion: nil)
        }
    }
    
    func setBottomSheetData(){
        deliveryTypeLabel.text = deliveryData.delivery_Type.rawValue == 0 ? "Normal" : "Urgent"
        deliveryTypeLabel.backgroundColor = deliveryData.delivery_Type.rawValue == 0 ? .blue : .red
        nameLabel.text = deliveryData.customer.customer_Name
        addressLabel.text = deliveryData.customer.customer_Address
        timeLabel.text = deliveryData.delivery_Time
    }
    
    func didReachAtDestination(){
        verificationTextLabel.isHidden = true
        verifyButtonView.isHidden = false
        Utility.instance.showAlert(title: "Alert", message: Strings.reached.localized)
    }
    
    // MARK: - Open Message Controller
    func sendSMS(phoneNumber:String){
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = ""
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
}


//MARK: - Tap Handlers of BottomSheetView
extension MapViewController {
    @IBAction func didTapCallButton() {
        Utility.instance.makeAPhoneCall(phoneNumber: deliveryData.customer.customer_PhoneNumber)
    }
    
    @IBAction func didTapSMSButton() {
        sendSMS(phoneNumber: deliveryData.customer.customer_PhoneNumber)
    }
    
    @IBAction func didTapVerifyButton() {
        let controller = CameraViewController(nibName: String.init(describing: CameraViewController.self), bundle: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


//MARK: - MessageComposeViewControllerDelegate
extension MapViewController: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
}
