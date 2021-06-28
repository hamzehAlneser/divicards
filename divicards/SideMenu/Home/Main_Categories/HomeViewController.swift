import UIKit
protocol HomeControllerDelegate {
    func didSelectCategory(subCategories : [CategoryData], paretId : String)
}
class HomeViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let homeRepositry = HomeRepositry()
    var allCategories : [CategoryData] = []
    
    var categories : [CategoryData] = []
    var delegate : HomeControllerDelegate?
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        startLoadingWithUIBlocker()
        
        homeRepositry.homeCategoriesRequest(completion: { response in
                
            if response?.success == "1"{
                self.allCategories = response!.data
                for cat in response!.data {
                    if cat.parent_id == "0" {
                        self.categories.append(cat)
                    }
                }
                self.collectionView.reloadData {
                    self.stopAnimating()
                }


            }
            else{
                self.view.makeToast(response?.message)
                
            }
        })

    }
//MARK:- Collection View Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else{fatalError("Failed")}
        let url = "http://divicards2.sensitivetime.com/" + self.categories[indexPath.row].image
        cell.imageView.load(url: url)
        cell.containerView.backgroundColor = getCategoryBackColor(catName: categories[indexPath.row].categories_name)
        
        return cell

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var a = self.allCategories[indexPath.row].categories_id
        var list : [CategoryData] = []
        for cat in self.allCategories {
            
            if a == cat.parent_id {
                list.append(cat)
            }
        }
        
        delegate?.didSelectCategory(subCategories: list,paretId: categories[indexPath.row].categories_id)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width : Int = Int(collectionView.bounds.width/2.1)
        var height = 0
        if getRandomProductSize() == 1 {
            height = 110
        }
        else{
            height = 140
        }

        return CGSize(width: width, height: height)
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
        DispatchQueue.global().async { [weak self] in
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

extension UICollectionView {
func reloadData(completion:@escaping ()->()) {
    UIView.animate(withDuration: 2, animations: { self.reloadData() })
        { _ in completion() }
}
}


