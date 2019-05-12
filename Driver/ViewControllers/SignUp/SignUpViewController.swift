//
//  SignUpViewController.swift
//  Driver
//
//  Created by Zeeshan on 5/5/19.
//  Copyright © 2019 Zeeshan. All rights reserved.
//

import UIKit
import ACFloatingTextfield_Swift

class SignUpViewController: BaseController {
    
    //MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var userNameTxt: ACFloatingTextfield!
    @IBOutlet weak var emailTxt: ACFloatingTextfield!
    @IBOutlet weak var passwordTxt: ACFloatingTextfield!
    @IBOutlet weak var confirmPasswordTxt: ACFloatingTextfield!
    
    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

//MARK: - Utility Methods
extension SignUpViewController {
    func setupUI(){
        headerView.addCurveWithGradient(headerColors: [Constants.App_Color3.cgColor, Constants.App_Color4.cgColor])
        signUpBtn.applyGradient(colors: [Constants.App_Color3.cgColor, Constants.App_Color4.cgColor])
        
        textFieldsSetup()
    }
    
    func textFieldsSetup(){
        userNameTxt.placeholder = "Username"
        emailTxt.placeholder = "Email"
        passwordTxt.placeholder = "Password"
        confirmPasswordTxt.placeholder = "Confirm Password"
        passwordTxt.isSecureTextEntry = true
        confirmPasswordTxt.isSecureTextEntry = true
    }
}


//MARK: - Tap Handlers
extension SignUpViewController {
    @IBAction func didTapSignupButton() {
        let controller = SignInViewController(nibName: String.init(describing: SignInViewController.self), bundle: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func didTapSigninButton() {
        let controller = SignInViewController(nibName: String.init(describing: SignInViewController.self), bundle: .main)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
