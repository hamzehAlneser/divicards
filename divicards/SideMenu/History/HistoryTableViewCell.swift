//
//  HistoryTableViewCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 21/07/2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
