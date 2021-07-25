//
//  LoginViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 20/04/2021.
//

import UIKit
import Toast_Swift
class LoginViewController: BaseViewController {
    var serviceConstants = ServiceConstants()
    let network: NetworkManager = NetworkManager.sharedInstance

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField:  UITextField!
      
        @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var notAMemberButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let loginRepositry = LoginRepositry()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.isUnreachable() { _ in
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.performSegue(withIdentifier: "HomeToNoWifi", sender: self)
        }
        let designHelper = DesignHelper()
        manageButtonsDesign(helper: designHelper)
        managetextFeildDesign(helper: designHelper)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {

        
        
        super.viewDidLoad()

        
        
        UserDefaults.standard.set(nil, forKey: "UserEmail") //setObject
        UserDefaults.standard.set(nil, forKey: "UserPassword")
        UserDefaults.standard.set(nil, forKey: "UserId") //setObject
        UserDefaults.standard.set(nil, forKey: "UserFirstName") //setObject
        UserDefaults.standard.set(nil, forKey: "UserLastName") //setObject
        UserDefaults.standard.set(nil, forKey: "UserPhone")
        UserDefaults.standard.set(nil, forKey: "UserGender")

    }
    

    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard var vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as? ForgotPasswordViewController else {  return }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailTextField.text == "" {
            self.view.makeToast("Enter email")
        }
        else if passwordTextField.text == "" {
            self.view.makeToast("Enter password")
        }
        else{
            loginUser(email: emailTextField.text!, password: passwordTextField.text!)
        }
    }
    
    //MARK:- Additional Methods
    
    //generating random nonce
    func generateUniqueNonce() -> String{
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./?!%^-+_=!@#$%^&*()"
           let len = UInt32(letters.length)

           var randomString = ""

           for _ in 0 ..< len {
               let rand = arc4random_uniform(len)
               var nextChar = letters.character(at: Int(rand))
               randomString += NSString(characters: &nextChar, length: 1) as String
           }

           return randomString
    }
    
    func loginUser(email : String , password : String) {
        startLoadingWithUIBlocker()
        loginRepositry.loginRequest(url:self.serviceConstants.loginUrl , email: email, password: password) { (response) in
            self.stopAnimating()

            if(response != nil){
                if response?.success == "1" {
                    var UserData = response?.data.first
                    UserDefaults.standard.set(UserData?.email, forKey: "UserEmail") //setObject
                    UserDefaults.standard.set(UserData?.password, forKey: "UserPassword")
                    UserDefaults.standard.set(UserData?.id, forKey: "UserId") //setObject
                    UserDefaults.standard.set(UserData?.first_name, forKey: "UserFirstName") //setObject
                    UserDefaults.standard.set(UserData?.last_name, forKey: "UserLastName") //setObject
                    UserDefaults.standard.set(UserData?.phone, forKey: "UserPhone")
                    UserDefaults.standard.set(UserData?.gender, forKey: "UserGender")
                    self.stopLoadingWithUIBlocker()
                    self.performSegue(withIdentifier: "LoginSegue", sender: self)
                }
                else{
                    self.view.makeToast(response?.message)
                }

            }else{
                self.view.makeToast("Error Connecting to server")
            }
        }
    }
    
    
    //design buttons
    func manageButtonsDesign(helper: DesignHelper) {
        helper.addButtonRoundedCornersWIthCenterText(button: loginButton)
        helper.addButtonRoundedCornersWIthCenterText(button: forgotPasswordButton)
        helper.addButtonRoundedCornersWIthCenterText(button: notAMemberButton)
        helper.addButtonRoundedCornersWIthCenterText(button: skipButton)
    }
    
    func managetextFeildDesign(helper: DesignHelper) {
        helper.addLineBelowTextField(textField: emailTextField) //Designing email TextField
        helper.addLineBelowTextField(textField: passwordTextField) //Designing Password
    }
    

    


}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
