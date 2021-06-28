//
//  TextFieldsHelper.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 23/04/2021.
//

import UIKit
class DesignHelper {
    func addLineBelowTextField(textField:UITextField){
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textField.frame.height+3, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.5591680408, green: 0.5558474064, blue: 0.5617226958, alpha: 1)
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    func addLineBelowTextFieldWithConstant(textField:UITextField,constant : CGFloat){
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textField.bounds.height+constant, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.5591680408, green: 0.5558474064, blue: 0.5617226958, alpha: 1)
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)
    }
    func addLineBelowTextView(textField:UITextView){
        let bottomLine = CALayer()

        bottomLine.frame = CGRect(x: 0, y: textField.frame.height-2, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = #colorLiteral(red: 0.5591680408, green: 0.5558474064, blue: 0.5617226958, alpha: 1)
        textField.layer.addSublayer(bottomLine)
    }
    
    func centreTextForButton(button : UIButton){
        button.titleLabel?.textAlignment = NSTextAlignment.center

    }
    
    func addButtonRoundedCornersWIthCenterText(button : UIButton){
        centreTextForButton(button: button)
        button.layer.cornerRadius = 10

        button.titleLabel?.textAlignment = NSTextAlignment.center
}
    

}
