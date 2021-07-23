//
//  OTPViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 23/07/2021.
//

import UIKit
import Toast_Swift
class OTPViewController: BaseViewController {
    var email : String?
    var pass : String?
    var phone : String?
    
    override func viewDidLoad() {
        self.view.makeToast("\(email! + pass! + phone!)")
    }
}
