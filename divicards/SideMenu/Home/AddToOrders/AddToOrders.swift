//
//  FinalPageViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 09/06/2021.
//

import UIKit
class AddToOrders: BaseViewController {
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var dileveryView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dileveryFeesLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
            navigationItem.titleView = imageView
    }
    
    var product : ProductData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageViews()
        manageButton()
        manageTextFields()
        fillInfo(product: self.product!)
    }


    func fillInfo(product : ProductData) {
        
        productLabel.text = product.products_name
        productPriceLabel.text = product.products_price
        contactTextField.text = UserDefaults.standard.string(forKey: "UserPhone")
        if UserDefaults.standard.string(forKey: "UserFirstName") != nil {
            nameLabel.text = UserDefaults.standard.string(forKey: "UserFirstName")! + UserDefaults.standard.string(forKey: "UserLastName")!
        }
        totalLabel.text = String(Double(product.products_price) ?? 100+2)
        
    }
    
    //MARK:- Extra Functions
    func manageViews() {
        productView.layer.cornerRadius = 5
        dileveryView.layer.cornerRadius = 5
        totalView.layer.cornerRadius = 5
    }
    
    func manageButton() {
        orderButton.layer.cornerRadius = 10
    }
    
    func manageTextFields() {
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.gray.cgColor
        nameLabel.layer.cornerRadius = 5
        
        contactTextField.layer.borderWidth = 1
        contactTextField.layer.borderColor = UIColor.gray.cgColor
        contactTextField.layer.cornerRadius = 5
        
        areaTextField.layer.borderWidth = 1
        areaTextField.layer.borderColor = UIColor.gray.cgColor
        areaTextField.layer.cornerRadius = 5
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func OrderNowPressed(_ sender: Any) {
        if nameLabel.text == "" {
            self.view.makeToast("Enter Name")
        }
        else if contactTextField.text == "" {
            self.view.makeToast("Enter Contact info")
        }
        else if areaTextField.text == "" {
            self.view.makeToast("Enter Area")
        }

        else {
            startLoadingWithUIBlocker()
            var productID = Int(self.product?.products_id ?? "0")
            var addToOrdersRepository = AddToOrdersRepository()
            addToOrdersRepository.AddToOrdersRequest(products_id: productID ?? 0, products_name: self.product?.products_name ?? "Unknown", price: self.product?.products_price ?? "Unknown", name: UserDefaults.standard.string(forKey: "UserFirstName") ?? "Unknown", phone: UserDefaults.standard.string(forKey: "UserPhone") ?? "Unknown") { response in
                self.stopAnimating()
                self.view.makeToast(response?.message)
            }
            }
        }
    }

