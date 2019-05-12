
import UIKit

class BaseController: UIViewController {
    //MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: - ViewController Methods
    override func loadView() {
        super.loadView()
        //* Disabling swipe back gesture *//
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //* Make default settings for nav bar *//
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //* Update status bar style *//
        self.setNeedsStatusBarAppearanceUpdate()
    }
}

//MARK: - Utility Methods
extension BaseController {
    
    func setupTransparentNavBar(){
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    @objc func addBackButton(color:UIColor = .gray){
        navigationItem.leftBarButtonItem =  UIBarButtonItem(image: #imageLiteral(resourceName: "back-arrow"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func addProfileButton(){
        let button = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "user"), for: .normal)
        button.addTarget(self, action:#selector(didTapProfileButton), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//MARK: - Tap Handlers
extension BaseController {
    @objc func didTapBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapProfileButton(){
        Utility.instance.showAlert(title: "Alert", message: Strings.implement_Later.localized)
    }
}

