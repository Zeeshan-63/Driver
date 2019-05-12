//
//  SignInViewController.swift
//  Driver
//
//  Created by Zeeshan on 5/4/19.
//  Copyright © 2019 Zeeshan. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class SignInViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var userNameTxt: ACFloatingTextfield!
    @IBOutlet weak var passwordTxt: ACFloatingTextfield!
    
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

//MARK: - Utility Methods
extension SignInViewController {
    func setupUI(){
        headerView.addCurveWithGradient(headerColors: [Constants.App_Color1.cgColor, Constants.App_Color2.cgColor])
        signInBtn.applyGradient(colors: [Constants.App_Color1.cgColor, Constants.App_Color2.cgColor])
        
        textFieldsSetup()
    }
    
    func textFieldsSetup(){
        userNameTxt.placeholder = "Username"
        passwordTxt.placeholder = "Password"
        passwordTxt.isSecureTextEntry = true
    }
}

//MARK: - Tap Handlers
extension SignInViewController {
    @IBAction func didTapSigninButton() {
        let controller = DeliveryListController(nibName: String.init(describing: DeliveryListController.self), bundle: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func didTapSignupButton() {
        let controller = SignUpViewController(nibName: String.init(describing: SignUpViewController.self), bundle: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func didTapForgotPasswordButton() {
        Utility.instance.showAlert(title: "Alert", message: Strings.implement_Later.localized)
    }
}
