//
//  CategoryCellCollectionViewCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 03/06/2021.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 15



}
}
