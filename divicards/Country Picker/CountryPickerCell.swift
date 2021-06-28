//
//  CountryPickerCell.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 02/05/2021.
//

import UIKit

class CountryPickerCell: UITableViewCell {

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var countryFlag: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        self.backgroundColor = .clear
        
        
        
        // Title
        self.nameLabel.textColor = .black
        
        self.codeLabel.textColor = .black
        

    }
    
}
