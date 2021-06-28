//
//  ProductCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 05/06/2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstTextField.layer.cornerRadius = 15
        firstTextField.clipsToBounds = true
        secondTextField.layer.cornerRadius = 10
        secondTextField.clipsToBounds = true
//        mainView.layer.cornerRadius = 15
    }

}
