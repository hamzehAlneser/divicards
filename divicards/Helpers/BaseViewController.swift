//
//  BaseViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 11/05/2021.
//

import UIKit
import NVActivityIndicatorView
import Alamofire
import AlamofireImage
class BaseViewController: UIViewController,NVActivityIndicatorViewable,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func startLoadingWithUIBlocker() {
        startAnimating(CGSize(width: 40, height: 40 ),message: nil, messageFont: nil, type: .circleStrokeSpin, color: UIColor(named: "loading"), padding: 0, displayTimeThreshold: nil, minimumDisplayTime: 0, backgroundColor: nil, textColor: nil, fadeInAnimation: nil)
    }
    
    func stopLoadingWithUIBlocker() {
        stopAnimating()
    }
    
    func startLoadingWithoutBlocker() {
        var indicatorView = NVActivityIndicatorView(frame: CGRect(x: 100, y: 100, width: 40, height: 40), type: .circleStrokeSpin, color: UIColor.green, padding: nil)

        indicatorView.startAnimating()
    }
    
    

}



