//
//  OTPViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 23/07/2021.
//

import UIKit
import Toast_Swift
import Firebase
class OTPViewController: BaseViewController {
    var email : String?
    var pass : String?
    var phone : String?
    var timeForResend = 60

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var otpCodeTextField: UITextField!
    override func viewDidLoad() {

        let designHelper = DesignHelper()
        designHelper.addLineBelowTextField(textField: otpCodeTextField)
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phone ?? "", uiDelegate: nil) { verificationID, error in
              if let error = error {
                self.view.makeToast(error.localizedDescription)
                return
              }
              // Sign in using the verificationID and the code sent to the user
              // ...
          }
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode(){

        
        if timeForResend >= 1{
            
        timerLabel.text = "Resend in \(timeForResend) Sec."
            timeForResend -= 1
        } else{
            verifyPhoneNumber()
            timeForResend = 60
        }
    }
    @IBAction func resendCodePressed(_ sender: Any) {
        verifyPhoneNumber()
    }
    @IBAction func verifyCodePrsedd(_ sender: Any) {
        if otpCodeTextField.text == "" {
            self.view.makeToast("Enter OTP")
        }
        else{
            verifyPhoneNumber()
        signIn(verificationCode: otpCodeTextField.text ?? "")
    }
    }
    
    //MARK:- OTP management
    func verifyPhoneNumber(){
        if self.navigationController?.topViewController is OTPViewController {
            
        
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phone ?? "", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.view.makeToast(error.localizedDescription)
            }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

                print("Code Sent")
        }
    }
    }
    
    func signIn(verificationCode : String){
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        if verificationID == nil {
            self.view.makeToast("Something went wrong")
        }
        else{
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode)

        

        Auth.auth().signIn(with: credential) { (authResult, authError) in
            if let error = authError{
                print("localazied error : \(error.localizedDescription)")
                self.view.makeToast(error.localizedDescription)
                }

            else{
                self.startLoadingWithUIBlocker()
                let registerRepository = RegisterRepositry()
                registerRepository.RegisterRequest(email: self.email ?? "", password: self.pass ?? "", phoneNumber: self.phone ?? "") { response in
                    if response != nil{
                        var UserData = response?.data.first
                        UserDefaults.standard.set(UserData?.id, forKey: "UserId")
                        UserDefaults.standard.set(UserData?.email, forKey: "UserEmail") //setObject
                        UserDefaults.standard.set(UserData?.password, forKey: "UserPassword")
                        UserDefaults.standard.set(UserData?.id, forKey: "UserId") //setObject
                        UserDefaults.standard.set(UserData?.first_name, forKey: "UserFirstName") //setObject
                        UserDefaults.standard.set(UserData?.last_name, forKey: "UserLastName") //setObject
                        UserDefaults.standard.set(UserData?.phone, forKey: "UserPhone")
                        UserDefaults.standard.set(UserData?.gender, forKey: "UserGender")
                      self.stopLoadingWithUIBlocker()
                     self.performSegue(withIdentifier: "OTPToHomeSegue", sender: self)
                    }
                    else{
                        self.view.makeToast("Something went wrong")
                    }
                }
        }
        
       
    }
        }

}
}
