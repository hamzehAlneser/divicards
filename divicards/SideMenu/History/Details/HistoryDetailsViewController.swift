//
//  HistoryDetailsViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 22/07/2021.
//

import UIKit
class HistoryDetailsViewController: BaseViewController, UIAdaptivePresentationControllerDelegate {
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var billingStreetLabel: UILabel!
    @IBOutlet weak var billingCityLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var streatAddressLabel: UILabel!
    @IBOutlet weak var shippingCityLabel: UILabel!
    @IBOutlet weak var shippingMethodLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var produ: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var imagePriceLabel: UILabel!
    @IBOutlet weak var imageTotalPrice: UILabel!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var shippingLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    var historyData : HistoryData?
    override func viewDidLoad() {
        fillLabels()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
            navigationItem.titleView = imageView
    }
    
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        false
    }
    
    func fillLabels() {

        totalPriceLabel.text = historyData?.orderPrice
        orderDateLabel.text = historyData?.datePurchased
        orderStatusLabel.text = historyData?.ordersStatus
        nameLabel.text = historyData?.billingName
        billingStreetLabel.text = historyData?.billingStreetAddress
        billingCityLabel.text = historyData?.billingCity
        fullnameLabel.text = historyData?.customersName
        shippingCityLabel.text = historyData?.customersCity
        streatAddressLabel.text = historyData?.customersStreetAddress
        shippingMethodLabel.text = historyData?.shippingMethod
        productNameLabel.text = historyData?.data[0].productsName
        imageTotalPrice.text = historyData?.orderPrice
        imageTotalPrice.text = historyData?.orderPrice
        produ.text = historyData?.data[0].categories[0].categoriesName
        let url = ("http://divicards2.sensitivetime.com/" + (self.historyData?.data[0].image ?? "")) ?? ""
        productImage.load(url: url)
        subtotalLabel.text = "\(historyData!.currency) \(historyData!.orderPrice)"
        taxLabel.text = "\(historyData!.currency) \(historyData!.totalTax)"
        shippingLabel.text = "\(historyData!.currency) \(historyData!.shippingCost)"
        discountLabel.text = "\(historyData!.currency) 0.00"
        totalLabel.text = "\(historyData!.currency) \(historyData!.orderPrice)"
    }
    
}
