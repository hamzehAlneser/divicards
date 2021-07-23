//
//  CategoryCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 28/06/2021.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var cellContentView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.cellContentView.layer.cornerRadius = 15
        // Configure the view for the selected state
    }
    
}
