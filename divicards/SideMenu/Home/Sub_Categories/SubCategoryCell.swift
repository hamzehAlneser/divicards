//
//  SubCategoryCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 04/06/2021.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var FirstImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 15
    }

}
