//
//  NotAMemberViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 21/04/2021.
//

import UIKit
class RegisterController: BaseViewController,CountryPickerDelegate {
    
    
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var countryPickView: UIView!
    @IBOutlet weak var pickCountryButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    

    var countryPickerVc : CountryPickerController? = nil
    var gender = "1"
    var code = "+962"
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default

        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIView()

        UserDefaults.standard.set(nil, forKey: "UserEmail") //setObject
        UserDefaults.standard.set(nil, forKey: "UserPassword")
        UserDefaults.standard.set(nil, forKey: "UserId") //setObject
        UserDefaults.standard.set(nil, forKey: "UserFirstName") //setObject
        UserDefaults.standard.set(nil, forKey: "UserLastName") //setObject
        UserDefaults.standard.set(nil, forKey: "UserPhone")
        UserDefaults.standard.set(nil, forKey: "UserGender")
        let designHelper = DesignHelper()
        manageButtonDesigns(helper: designHelper)
        managetextFieldDesigns(helper: designHelper)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         countryPickerVc = storyBoard.instantiateViewController(identifier: "CountryPickerView") as! CountryPickerController
        countryPickerVc?.delegate = self
        
        managePickCountryView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RegisterToOTP" {
            let vc = segue.destination as! OTPViewController
            vc.email = emailAddressTextField.text
            vc.pass = passwordTextField.text
            vc.phone = "\(code + phoneNumberTextField.text!)"
        }
    }
    @IBAction func loginPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let registerRepositry = RegisterRepositry()
        if emailAddressTextField.text == "" {
            self.view.makeToast("Enter email")
        }
        else if !isValidEmail(emailAddressTextField.text!){
            self.view.makeToast("Invalid Email Format")
        }
        else if passwordTextField.text == "" {
            self.view.makeToast("Enter password")
        }
        else if passwordTextField.text?.count ?? 0 < 6 {
            self.view.makeToast("Password must contain 6 characters at least")
        }
        else if confirmPasswordTextField.text == "" {
            self.view.makeToast("Reneter Password")
        }
        else if passwordTextField.text != confirmPasswordTextField.text {
            self.view.makeToast("Passwords Dont Match")
        }
        else if phoneNumberTextField.text == "" {
            self.view.makeToast("Enter Phone Number")
        }

        else {
            performSegue(withIdentifier: "RegisterToOTP", sender: self)
        
//            startLoadingWithUIBlocker()
//            registerRepositry.RegisterRequest(firstName: firstNameTextField.text!, lastname: lastNameTextField.text!, email: emailAddressTextField.text!, password: passwordTextField.text!, phoneNumber: "\(code + phoneNumberTextField.text!)", gender: self.gender) { response in
//                self.stopLoadingWithUIBlocker()
//                self.performSegue(withIdentifier: "RegisterToHomeSegue", sender: self)
            }
        
        
    }

    
    
    @IBAction func pickCountryPressed(_ sender: Any) {
        if countryPickerVc == nil {

        }
        else {
            present(self.countryPickerVc!, animated: true, completion: nil)

        }
        
    }
    func didPickCountry(flag: String, name: String,countryCode : String, code: String) {
        print(name)
        self.countryPickerVc?.dismiss(animated: true,completion: {
            self.pickCountryButton.setTitle(IsoCountries.flag(countryCode: countryCode)! + " \(countryCode) \(code)  ???", for: .normal)
            var c = code
            c.remove(at: c.startIndex)
            self.code = "+"
            self.code += c
        })
    }
    
    //MARK:- Extra functions
    
    //design buttons and textfields
    func manageButtonDesigns (helper : DesignHelper) {
        helper.addButtonRoundedCornersWIthCenterText(button: registerButton)
        helper.addButtonRoundedCornersWIthCenterText(button: loginButton)
    }
    
    func managetextFieldDesigns (helper : DesignHelper) {

        helper.addLineBelowTextField(textField: emailAddressTextField)
        helper.addLineBelowTextField(textField: passwordTextField)
        helper.addLineBelowTextField(textField: confirmPasswordTextField)

    }
    
    //manage picker
    func managePickCountryView() {
        self.countryPickView.layer.cornerRadius = 15
        self.countryPickView.layer.borderWidth = 1
        self.countryPickView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.countryPickView.backgroundColor = .white
        pickCountryButton.backgroundColor = .clear
        pickCountryButton.setTitle(IsoCountries.flag(countryCode: "JO")! + " JO +962" + " ???", for: .normal)
    }

    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
