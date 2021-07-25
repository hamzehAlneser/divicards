//
//  ProductsViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 05/06/2021.
//
import Toast_Swift
import UIKit
class ProductsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let productReporsitry = ProductRepositry()
    var products = [ProductData]()
    var selectedProduct : ProductData?
    
    var catId : String?
    var selectedCatParentId : String?
    
    var selectedIndex : Int?

    override func viewWillAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
            navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "main_logo")
            imageView.image = image
        startLoadingWithUIBlocker()
        productReporsitry.productsRequest(catId: catId ?? "0") { response in
            if(self.catId == "0"){
                self.view.makeToast("Error")
                return  }
            self.startAnimating()
            if(response != nil){

                if (response?.product_data.count)! > 0 {
                    var list = response!.product_data
                    for product in list {
                        self.products.append(product)

                    }
                    self.collectionView.reloadData {
                        self.stopAnimating()
                        var a = self.catId
                    }
                }
                else{self.stopAnimating()
                    self.view.makeToast("Nil")
                }
            }
            else{
                self.stopAnimating()
                self.view.makeToast("response Nil")
            }
        }

    
    }
    
//MARK:- Collection view methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else{fatalError("Failed")}
        let url = "http://divicards2.sensitivetime.com/" + self.products[indexPath.row].products_image
        cell.image.load(url: url)
        cell.firstTextField.text = "\(products[indexPath.row].currency) \(products[indexPath.row].products_price)"
        cell.secondTextField.text = products[indexPath.row].products_name
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : Int = Int(collectionView.bounds.width/2.1)
        return CGSize(width: width, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProduct = products[indexPath.row]
        performSegue(withIdentifier: "ProductToCheckout", sender: self)
    }
    
    //MARK:- Extra Functions
    @IBAction func exitButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func roundTOJOD(value : String) -> Double{
        var numericValue = Double(value) ?? 1000
        let y = Double(round(100*numericValue)/100) ?? 100
        return(y)  // 1.236
    }
    
}
extension ProductsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductToCheckout" {
            if let productVc = segue.destination as? CheckoutViewController {
                productVc.selectedProduct = selectedProduct
            }
        }
    }
}
