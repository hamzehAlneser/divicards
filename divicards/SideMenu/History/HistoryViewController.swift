//
//  HistoryViewController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 01/05/2021.
//

import UIKit
import Toast_Swift
class HistoryViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedHistory : HistoryData?
    var HistoryData : [HistoryData] = []
    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        let historyRepository = HistoryRepository()
        startLoadingWithUIBlocker()
        historyRepository.HistoryRequest() { response in
            if(response != nil){
                self.HistoryData = response?.data ?? []
                self.historyTableView.reloadData {
                    self.stopAnimating()
                }
        }

    }
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryToDetails" {
            let vc = segue.destination as! HistoryDetailsViewController
            vc.historyData = self.selectedHistory
        }
    }
    //MARK:- TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.HistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else{fatalError("Failed")}
        cell.DateLabel.text = self.HistoryData[indexPath.row].datePurchased
        cell.priceLabel.text = self.HistoryData[indexPath.row].orderPrice
        cell.orderIDLabel.text = self.HistoryData[indexPath.row].ordersID
        cell.selectionStyle = .none
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedHistory = self.HistoryData[indexPath.row]
        performSegue(withIdentifier: "HistoryToDetails", sender: self)
    }
}
