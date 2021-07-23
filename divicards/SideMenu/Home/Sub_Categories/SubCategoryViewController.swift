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
    var selectedCatdId : String?
    var selectedCatParentId : String?
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
        let url = "http://divicards2.sensitivetime.com/" + self.subCategories[indexPath.row].image
        cell.FirstImage.load(url: url)
        cell.catLabel.text = subCategories[indexPath.row].categories_name
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

        return CGSize(width: 150, height: 150)
    }

}
