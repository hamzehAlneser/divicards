//
//  CheckoutViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 05/06/2021.
//

import UIKit
import SwiftSoup
class CheckoutViewController: BaseViewController {
    
    @IBOutlet weak var stockButton: UIButton!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var inStockLabe: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var selectedProduct : ProductData?
    
    override func viewWillAppear(_ animated: Bool) {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        imageView.contentMode = .scaleAspectFit
//            let image = UIImage(named: "main_logo")
//            imageView.image = image
//            navigationItem.titleView = imageView
        addLogoToNavigationBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTextField.layer.cornerRadius = 15
        let backImage = UIImage(systemName: "arrow.backward")!.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -80.0), for: .default)
        
        fillProductInfo(product: selectedProduct!)
    }
    @IBAction func buttonPressed(_ sender: Any) {
        if (selectedProduct!.defaultStock != 0) {
            performSegue(withIdentifier: "checkoutToCredit", sender: self)
        }
        else {
            self.view.makeToast("Product out of stock")
        }
    }
    
    @IBAction func backNavItemPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func fillProductInfo(product : ProductData) {
        priceTextField.text = product.products_name
//        priceTextField.text = "divicards products"
        let url = "https://divi-cards.com/" + product.products_image
//        productImage.image = UIImage(named: "card")
        productImage.load(url: url)
        if product.defaultStock > 0 {
            inStockLabe.text = "In Stock"
            inStockLabe.textColor = #colorLiteral(red: 0.20513919, green: 0.5954503417, blue: 0.8653187156, alpha: 1)
            stockButton.setTitle("Proceed", for: .normal)
            stockButton.backgroundColor = #colorLiteral(red: 0.20513919, green: 0.5954503417, blue: 0.8653187156, alpha: 1)
            stockButton.layer.cornerRadius = 20
        }
        else{
            inStockLabe.text = "Out of Stock"
            inStockLabe.textColor = UIColor.red
        }
        infoLabel.text = product.products_name
//        infoLabel.text = "Divicards"
        let helper = DesignHelper()
        helper.addLineBelowTextFieldWithConstant(textField: infoTextField, constant: 0)
        infoTextField.text = product.categories.first?.categories_name
//        infoTextField.text = "divicards products"
        descriptionTextView.attributedText = selectedProduct?.products_description.htmlToAttributedString
//            descriptionTextView.text = "divicards products"
        
    }
}
extension CheckoutViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkoutToCredit" {
            if let creditVc = segue.destination as? CreditCardViewController {
                creditVc.product = self.selectedProduct
            }
        }
    }
}
