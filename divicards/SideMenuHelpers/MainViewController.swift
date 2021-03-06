//
//  MainViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 01/05/2021.
//

import UIKit
protocol MainMenuDelegate  {
    func DidNavigateToCategories(parentId : String)
}
class MainViewController: UIViewController, SideMenuViewControllerDelegate, HomeControllerDelegate {
    var parentID : Int = 0
    func didSelectCategory(subCategories: [CategoryData], paretId: Int) {
        self.parentID = paretId
        showSubViewController(parentId : paretId,data: subCategories)
    }
    
    
    func DidSelectItem(parentId: String) {
        self.showViewController(viewController: UINavigationController.self, storyboardId: "SubCategoriesID")

    }
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 0
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    var navBarHeight : CGFloat = 0.0
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var delegate : MainMenuDelegate?
    private var revealSideMenuOnTop: Bool = true
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
             navigationController?.navigationBar.setNeedsLayout()
            navigationController?.navigationBar.barStyle = .default

        }

        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        imageView.contentMode = .scaleAspectFit
//            let image = UIImage(named: "main_logo")
//            imageView.image = image
//            navigationItem.titleView = imageView
        addLogoToNavigationBarItem()
        
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        sideMenuRevealWidth = self.view.bounds.width/1.5
        navBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (navigationController?.navigationBar.frame.height)! ?? 0.0
        self.sideMenuShadowView = UIView(frame: CGRect(x: 0, y: navBarHeight, width: self.view.bounds.width, height: self.view.bounds.height))
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ShadhowTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuID") as? SideMenuViewController
        self.sideMenuViewController.defaultHighlightedCell = 0 // Default Highlighted Cell
        self.sideMenuViewController.delegate = self
        self.sideMenuViewController.view.isHidden = true
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        // Side Menu AutoLayout

        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false

        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: navBarHeight)
        ])
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
        // ...


       // Default Main View Controller
        showViewController(viewController: UIViewController.self, storyboardId: "HomeNav")
        
    }
    
    @IBAction open func revealSideMenu() {
        self.sideMenuViewController.view.isHidden = false
        self.sideMenuState(expanded: self.isExpanded ? false : true)
        
    }
}


extension MainViewController {
    func selectedCell(_ name: String) {
        switch name {
        case "Home":
            // Home
            self.showViewController(viewController: UIViewController.self, storyboardId: "HomeNav")
        case "Offers":
            // Music
            self.showViewController(viewController: UIViewController.self, storyboardId: "OffersNav")
        case "Profile":
            // Music
            if UserDefaults.standard.string(forKey: "UserId") == nil {
                self.navigationController?.popToRootViewController(animated: true)
            }
            else {
                self.showViewController(viewController: UIViewController.self, storyboardId: "ProfileNav")

            }
        case "History":
            if UserDefaults.standard.string(forKey: "UserId") == nil {
                self.navigationController?.popViewController(animated: true)
            }
            else {
                self.showViewController(viewController: UIViewController.self, storyboardId: "HistoryNav")

            }
            // Music
            
        case "My Master Card":
            // Home
            self.showViewController(viewController: UIViewController.self, storyboardId: "MasterCardNav")
        case "About Us":
            var a = 5
            // Music
//            self.showViewController(viewController: UIViewController.self, storyboardId: "AboutUsNav")
        case "Contact Us":
            var a = 5
            // Music
//            self.showViewController(viewController: UIViewController.self, storyboardId: "ContactUsNav")
        case "Login":
            // Music
//            self.dismiss(animated: false, completion: nil)
            self.sideMenuViewController.dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)

            }

//            dismiss(animated: true, completion: nil)
            
        case "Logout":
            // Music
//            self.dismiss(animated: false, completion: nil)
            UserDefaults.standard.set(nil, forKey: "UserEmail") //setObject
            UserDefaults.standard.set(nil, forKey: "UserPassword")
            UserDefaults.standard.set(nil, forKey: "UserId") //setObject
            UserDefaults.standard.set(nil, forKey: "UserFirstName") //setObject
            UserDefaults.standard.set(nil, forKey: "UserLastName") //setObject
            UserDefaults.standard.set(nil, forKey: "UserPhone")
            UserDefaults.standard.set(nil, forKey: "UserGender")
            self.navigationController?.popToRootViewController(animated: true)

        default:
            break
        }

        // Collapse side menu with animation
        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
    }

    func showViewController<T: UIViewController>(viewController: T.Type, storyboardId: String) -> () {
        // Remove the previous View
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if storyboardId == "HomeNav" {
            var vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! HomeViewController
            vc.delegate = self
            vc.view.tag = 99
            view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
            addChild(vc)
            if !self.revealSideMenuOnTop {
                if isExpanded {
                    vc.view.frame.origin.x = self.sideMenuRevealWidth
                }
                if self.sideMenuShadowView != nil {
                    vc.view.addSubview(self.sideMenuShadowView)
                }
            }
            vc.didMove(toParent: self)
        }
        
        else{
            var vc = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
            
            
            vc.view.tag = 99
            view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
            addChild(vc)
            if !self.revealSideMenuOnTop {
                if isExpanded {
                    vc.view.frame.origin.x = self.sideMenuRevealWidth
                }
                if self.sideMenuShadowView != nil {
                    vc.view.addSubview(self.sideMenuShadowView)
                }
            }
            vc.didMove(toParent: self)}

    }

    
    func showSubViewController(parentId : Int, data : [CategoryData]) -> () {
        // Remove the previous View
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SubCatNav") as! SubCategoriesViewController
        self.sideMenuBtn.image = UIImage(systemName: "arrow.backward")
        self.sideMenuBtn.action = #selector(buttonAction)
            vc.fillCollectionView(selectedSubCategories: data)
            vc.selectedCatParentId = parentId
        


        vc.view.tag = 99
        view.insertSubview(vc.view, at: self.revealSideMenuOnTop ? 0 : 1)
        addChild(vc)
        if !self.revealSideMenuOnTop {
            if isExpanded {
                vc.view.frame.origin.x = self.sideMenuRevealWidth
            }
            if self.sideMenuShadowView != nil {
                vc.view.addSubview(self.sideMenuShadowView)
            }
        }
        vc.didMove(toParent: self)
        


    }
    @objc func buttonAction() {
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)

        self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
            self.isExpanded = false
        }
        self.sideMenuBtn.image = UIImage(systemName: "line.horizontal.3")

        // Animate Shadow (Fade Out)
        UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        self.showViewController(viewController: UIViewController.self, storyboardId: "HomeNav")
    }

    func sideMenuState(expanded: Bool) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        if expanded {
            self.sideMenuBtn.image = UIImage(systemName: "arrow.backward")

//            view.addGestureRecognizer(tapGestureRecognizer)
//            tapGestureRecognizer.isEnabled = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
                
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            self.sideMenuBtn.image = UIImage(systemName: "line.horizontal.3")

            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            view.removeGestureRecognizer(tapGestureRecognizer)
            tapGestureRecognizer.isEnabled = false
        }
    }

    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
}

extension UIViewController {
    
    // With this extension you can access the MainViewController from the child view controllers.
    func revealViewController() -> MainViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is MainViewController {
            return viewController! as? MainViewController
        }
        while (!(viewController is MainViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is MainViewController {
            return viewController as? MainViewController
        }
        return nil
    }
    

    
}
extension MainViewController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    @objc func ShadhowTapped() {
        sideMenuState(expanded: false)
    }

    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // ...
}

extension MainViewController {
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        // ...

        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x

        switch sender.state {
        case .began:

            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }

            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging they collapsing the side menu)
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }

            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }

                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }

        case .changed:

            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha

                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                       // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha

                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animationse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}


    
    



