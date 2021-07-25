import UIKit
protocol HomeControllerDelegate {
    func didSelectCategory(subCategories : [CategoryData], paretId : String)
}
class HomeViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!

    @IBOutlet weak var contentViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var ContentView: UIView!
    
    let homeRepositry = HomeRepositry()

    var allCategories : [CategoryData] = []
    var categories : [CategoryData] = []
    var leftCategories : [CategoryData] = []
    var rightCategories : [CategoryData] = []

    var delegate : HomeControllerDelegate?
    var contentViewHeight: Double = 0.0
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var selectedCatID : String = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToProducts" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let topVc = destinationNavigationController.topViewController
            if let productVc = topVc as? ProductsViewController{
                productVc.catId = self.selectedCatID
//                productVc.selectedCatParentId = selectedCatParentId
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        rightTableView.delegate = self
        rightTableView.dataSource = self
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        rightTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        leftTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")

        startLoadingWithUIBlocker()
        
        homeRepositry.homeCategoriesRequest(completion: { response in
                
            if response?.success == "1"{
                self.allCategories = response!.data
                for cat in response!.data {
                    if cat.parent_id == "0" {
                        self.categories.append(cat)
                    }
                }
                
                var half : Int = self.categories.count/2
                for index in 0...half-1 {
                    self.leftCategories.append(self.categories[index])
                }
                for index in half...self.categories.count-1 {
                    self.rightCategories.append(self.categories[index])
                }
                
                self.rightTableView.reloadData {
                }
                self.leftTableView.reloadData {
                    self.contentViewHeightConst.constant = CGFloat(self.contentViewHeight)
                    self.ContentView.layoutIfNeeded()
                    self.stopAnimating()
                }


            }
            else{
                self.view.makeToast(response?.message)
                
            }
        })

    }
//MARK:- Collection View Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else{fatalError("Failed")}
        if tableView == leftTableView {
            let url = "http://divicards2.sensitivetime.com/" + self.leftCategories[indexPath.row].image
            cell.catImage.load(url: url)
            cell.cellContentView.backgroundColor = getCategoryBackColor(catName: leftCategories[indexPath.row].categories_name)
        }
        else{
            let url = "http://divicards2.sensitivetime.com/" + self.rightCategories[indexPath.row].image
            cell.catImage.load(url: url)
            cell.cellContentView.backgroundColor = getCategoryBackColor(catName: rightCategories[indexPath.row].categories_name)
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftCategories.count
        }
        else{
        return rightCategories.count
        }
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            var selectedCatId = self.leftCategories[indexPath.row].categories_id
            var list : [CategoryData] = []
            for cat in self.allCategories {
                
                if selectedCatId == cat.parent_id {
                    list.append(cat)
                }
            }
            if !list.isEmpty {
                delegate?.didSelectCategory(subCategories: list,paretId: leftCategories[indexPath.row].categories_id)

            }
            else{
                self.selectedCatID = selectedCatId
                performSegue(withIdentifier: "HomeToProducts", sender: self)
            }
        }
        else {
            var selectedCatId = self.rightCategories[indexPath.row].categories_id
            var list : [CategoryData] = []
            for cat in self.allCategories {
                
                if selectedCatId == cat.parent_id {
                    list.append(cat)
                }
            }
            
            if !list.isEmpty {
                delegate?.didSelectCategory(subCategories: list,paretId: rightCategories[indexPath.row].categories_id)
            }
            else{
                self.selectedCatID = selectedCatId
                performSegue(withIdentifier: "HomeToProducts", sender: self)
            }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 0
        if getRandomProductSize() == 1 {
             height = 120
            if tableView == leftTableView {
                contentViewHeight += 50
            }
         }
         else{
            height = 170
            if tableView == leftTableView {
                contentViewHeight += 70
            }
         }
        return height
    }
    //MARK:- Extra Functions
        func getRandomProductSize() -> Int{
            let random = Int.random(in: 1...2)

            return random
        }
    
    
    func getCategoryBackColor(catName : String) -> UIColor {
        switch catName {
        case "Amazon":
            return UIColor(named: "amazonBackColor") ?? UIColor.white
        case "Ebay":
            return UIColor(named: "ebayBackColor") ?? UIColor.white
        case "Fifa":
            return UIColor(named: "fifaBackColor") ?? UIColor.white
        case "Fortnite":
            return UIColor(named: "fortniteBackColor") ?? UIColor.white
        case "Google Play":
            return UIColor(named: "googleplayBackColor") ?? UIColor.white
        case "itunes":
            return UIColor(named: "itunesBackColor") ?? UIColor.white
        case "Netflix":
            return UIColor(named: "netflixBackColor") ?? UIColor.white
        case "Play station":
            return UIColor(named: "playstationBackColor") ?? UIColor.white
        case "Steam":
            return UIColor(named: "steamBackColor") ?? UIColor.white
            
            //
        case "AMEX":
            return UIColor(named: "amexBackColor") ?? UIColor.white
        case "Apple Music":
            return UIColor(named: "applemusicBackColor") ?? UIColor.white
        case "Blizzard":
            return UIColor(named: "blizzardBackColor") ?? UIColor.white
        case "Facebook":
            return UIColor(named: "facebookBackColor") ?? UIColor.white
        case "freefire":
            return UIColor(named: "freefireBackColor") ?? UIColor.white
        case "Nitando":
            return UIColor(named: "nitandoBackColor") ?? UIColor.white
        case "PubG":
            return UIColor(named: "pubgBackColor") ?? UIColor.white
        case "Razzer Gold":
            return UIColor(named: "razzergoldBackColor") ?? UIColor.white
        case "Riot Access":
            return UIColor(named: "riotaccessBackColor") ?? UIColor.white
           
        //
        case "Rixty":
            return UIColor(named: "rixtyBackColor") ?? UIColor.white
        case "Show Time":
            return UIColor(named: "showtimeBackColor") ?? UIColor.white
        case "Skype":
            return UIColor(named: "skypeBackColor") ?? UIColor.white
        case "Starz Play":
            return UIColor(named: "starzplayBackColor") ?? UIColor.white
        case "Visa":
            return UIColor(named: "visaBackColor") ?? UIColor.white
        case "Xbox":
            return UIColor(named: "xboxBackColor") ?? UIColor.white
        case "Xbox game pass":
            return UIColor(named: "xboxpassBackColor") ?? UIColor.white
        case "Master Cards":
            return UIColor(named: "mastercardBackColor") ?? UIColor.white

            
        default:
            UIColor.white
        }
        return UIColor.white
    }
        
    }
    
extension UIImageView{
    func load(url:String) {
        guard let url = URL(string: url) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    
    
}

extension UITableView {
func reloadData(completion:@escaping ()->()) {
    UIView.animate(withDuration: 2, animations: { self.reloadData() })
        { _ in completion() }
}
}

extension UICollectionView {
func reloadData(completion:@escaping ()->()) {
    UIView.animate(withDuration: 2, animations: { self.reloadData() })
        { _ in completion() }
}
}


