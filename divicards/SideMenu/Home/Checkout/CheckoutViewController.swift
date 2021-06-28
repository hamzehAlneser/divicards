//
//  CheckoutViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 05/06/2021.
//

import UIKit
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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
            navigationItem.titleView = imageView
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
        performSegue(withIdentifier: "checkoutToCredit", sender: self)
    }
    
    @IBAction func backNavItemPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func fillProductInfo(product : ProductData) {
        priceTextField.text = product.products_name
        let url = "http://divicards2.sensitivetime.com/" + product.products_image
        productImage.load(url: url)
        if Int(product.products_quantity)! > 0 {
            inStockLabe.text = "In Stock"
            stockButton.titleLabel?.text = "Proceed"
            stockButton.backgroundColor = UIColor.blue
        }
        else{
            inStockLabe.text = "Out of Stock"
            inStockLabe.textColor = UIColor.red
        }
        infoLabel.text = product.products_name
        let helper = DesignHelper()
        helper.addLineBelowTextFieldWithConstant(textField: infoTextField, constant: 0)
        infoTextField.text = product.categories.first?.categories_name
        descriptionTextView.text = product.products_description
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
