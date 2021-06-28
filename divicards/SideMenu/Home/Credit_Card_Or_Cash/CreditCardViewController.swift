//
//  CreditCardViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 06/06/2021.
//

import UIKit
class CreditCardViewController: UIViewController {
    @IBOutlet weak var deliveryOnCachButton: UIButton!
    @IBOutlet weak var creditCardView: UIView!
    
    var product : ProductData?
    
    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
            navigationItem.titleView = imageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.layer.cornerRadius = 15
        creditCardView.layer.borderWidth = 0.3
        creditCardView.layer.borderColor = UIColor.gray.cgColor
        deliveryOnCachButton.layer.cornerRadius = 15
        deliveryOnCachButton.layer.borderWidth = 0.3
        deliveryOnCachButton.layer.borderColor = UIColor.gray.cgColor
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func deliveryButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "creditToFinalSegue", sender: self)
    }
}

extension CreditCardViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "creditToFinalSegue" {
            if let finalVc = segue.destination as? FinalPageViewController {
                finalVc.product = self.product
            }
        }
    }
}
