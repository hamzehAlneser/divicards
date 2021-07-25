//
//  SideMEnuViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 01/05/2021.
//

import UIKit
protocol SideMenuViewControllerDelegate {
    func selectedCell(_ name: String)
}
class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var sideMenuTableView: UITableView!

    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(named: "HomeLogo")!, title: "Home"),
        SideMenuModel(icon: UIImage(named:"OffersLogo")!, title: "Offers"),
        SideMenuModel(icon: UIImage(named:"ProfileLogo")!, title: "Profile"),
        SideMenuModel(icon: UIImage(named:"HistoryLogo")!, title: "History"),
        SideMenuModel(icon: UIImage(), title: "About Us"),
        SideMenuModel(icon: UIImage(), title: "Contact Us"),
        

    ]
    
    
    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = .white
        self.sideMenuTableView.separatorStyle = .none
        if UserDefaults.standard.string(forKey: "UserId") != nil {
            menu.append(SideMenuModel(icon: UIImage(), title: "Logout"))

        }
        else{menu.append(SideMenuModel(icon: UIImage(), title: "Login"))}




        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)

        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
}

extension SideMenuViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }

        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title

        // Highlighted color
//        let myCustomSelectionColorView = UIView()
//        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
//        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.selectedCell(menu[indexPath.row].title)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    }


