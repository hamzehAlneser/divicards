//
//  ProfileViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 01/05/2021.
//

import UIKit
import Toast_Swift
class ProfileViewController: BaseViewController {
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var helper = DesignHelper()
    let profileRepositry = ProfileRepositry()

    override func viewDidLoad() {
        super.viewDidLoad()
        managetextFieldDesigns(helper: helper)
        imageView.layer.cornerRadius = imageView.bounds.height / 2.0
        self.imageView.layer.masksToBounds = true
        fillTextFieldsPlaceHolder()
    }
    
    func managetextFieldDesigns (helper : DesignHelper) {
        helper.addLineBelowTextField(textField: nameTextField)
        helper.addLineBelowTextField(textField: emailTextField)
        helper.addLineBelowTextField(textField: phoneNumberTextField)
        helper.addLineBelowTextField(textField: lastNameTextField)
    }
    
    func fillTextFieldsPlaceHolder() {
        nameTextField.text = UserDefaults.standard.string(forKey: "UserFirstName")
        lastNameTextField.text = "Area"
        emailTextField.text = UserDefaults.standard.string(forKey: "UserEmail")
        phoneNumberTextField.text = UserDefaults.standard.string(forKey: "UserPhone")
        
    }

    @IBAction func saveButtonPressed(_ sender: Any) {
        startLoadingWithUIBlocker()
        let firstName = nameTextField.text
        let lastName = lastNameTextField.text
        let email = emailTextField.text
        let phone = phoneNumberTextField.text
        
        profileRepositry.UpdateInfoRequest(id: UserDefaults.standard.string(forKey: "UserId")!, fName: firstName ?? " ", lName: lastName ?? " ", phone: phone ?? " ", gender: UserDefaults.standard.string(forKey: "UserGender")!, dob: "5-8-1998", changePassword: "no") { response in
            self.stopLoadingWithUIBlocker()
            if response?.success == "1"{
                UserDefaults.standard.set(response?.data.first?.id, forKey: "UserId") //setObject
                UserDefaults.standard.set(response?.data.first?.first_name, forKey: "UserFirstName") //setObject
                UserDefaults.standard.set(response?.data.first?.last_name, forKey: "UserLastName") //setObject
                UserDefaults.standard.set(response?.data.first?.phone, forKey: "UserPhone")
                UserDefaults.standard.set(response?.data.first?.gender, forKey: "UserGender")
                self.view.makeToast("Profile Updated Successfuly")
            }
            else{
                self.view.makeToast(response?.message)
                
            }
            
        }
        
        
        
        
        
    }
}
