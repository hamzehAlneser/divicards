//
//  File.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 31/05/2021.
//

import UIKit
protocol SubCategoryDelegate {
    func didSelectCell(id : String)
}
class SubCategoriesViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var delegate : SubCategoryDelegate?
    var parentId : Int?
    var subCategories : [CategoryData] = []
    var selectedCatdId : Int?
    var selectedCatParentId : Int?
    private let spacing:CGFloat = 10.0

    @IBOutlet weak var collectionView: UICollectionView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "SubCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SubCatCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData {self.stopAnimating()}
    }
    
    //MARK:- Extra functions Functions
    func fillCollectionView(selectedSubCategories : [CategoryData]) {
        self.subCategories = selectedSubCategories
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SubToProducts" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let topVc = destinationNavigationController.topViewController
            if let productVc = topVc as? ProductsViewController{
                productVc.catId = selectedCatdId
                productVc.selectedCatParentId = selectedCatParentId
            }
        }
    }
    
    //MARK:- Collection view methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCatCell", for: indexPath) as? SubCategoryCell else{fatalError("Failed")}
        let url = "https://divi-cards.com/" + self.subCategories[indexPath.row].image
//        cell.FirstImage.image = UIImage(named: "card")
        cell.FirstImage.load(url: url)
        cell.catLabel.text = subCategories[indexPath.row].categories_name
//        cell.catLabel.text = "DiviCards Sub"
        return cell

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedCatdId = subCategories[indexPath.row].categories_id
        
            performSegue(withIdentifier: "SubToProducts", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 10
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.collectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }


}
