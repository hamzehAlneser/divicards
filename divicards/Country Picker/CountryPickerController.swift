//
//  CountryPickerController.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 02/05/2021.
//

import UIKit
protocol CountryPickerDelegate {
    func didPickCountry(flag : String, name : String,countryCode:String, code : String)
    
}
class CountryPickerController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {

    

    @IBOutlet weak var searchTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    var countreis = [CountryPickerModel]()
    var delegate : CountryPickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        var designHelper = DesignHelper()
        tableView.delegate = self
        tableView.dataSource = self
        searchTextView.delegate = self
        searchTextView.text = "Search.."
        designHelper.addLineBelowTextView(textField: searchTextView)
        searchTextView.textColor = UIColor.lightGray
        
        
        self.tableView.register(CountryPickerCell.nib, forCellReuseIdentifier: CountryPickerCell.identifier)

        // Update TableView with the data
        self.tableView.reloadData()

        for country in IsoCountries.allCountries {
            countreis.append(CountryPickerModel(flag: IsoCountries.flag(countryCode: country.alpha2) ?? "", name: country.name,countryCode : country.alpha2, code: country.calling))
        }
    }

    // MARK:- Table view Managment

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countreis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPickerCell.identifier) as? CountryPickerCell else { fatalError("xib doesn't exist") }
        cell.countryFlag.text = countreis[indexPath.row].flag
        cell.nameLabel.text = countreis[indexPath.row].name
        cell.codeLabel.text = countreis[indexPath.row].code
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didPickCountry(flag: countreis[indexPath.row].flag, name: countreis[indexPath.row].name,countryCode: countreis[indexPath.row].countryCode, code: countreis[indexPath.row].code)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Search TextView Managment
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Search ..."
            textView.textColor = UIColor.lightGray
            countreis = []
            for country in IsoCountries.allCountries {
                countreis.append(CountryPickerModel(flag: IsoCountries.flag(countryCode: country.alpha2) ?? "", name: country.name,countryCode : country.alpha2, code: country.calling))
            }
            self.tableView.reloadData()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if textView.text == "" {
            countreis = []
            for country in IsoCountries.allCountries {
                countreis.append(CountryPickerModel(flag: IsoCountries.flag(countryCode: country.alpha2) ?? "", name: country.name,countryCode : country.alpha2, code: country.calling))
            }
            self.tableView.reloadData()
        }
        let newCountries = IsoCountryCodes.searchByName(textView.text)
        if let countries2 = newCountries {
            countreis = [CountryPickerModel]()
            for country in countries2 {
                countreis.append(CountryPickerModel(flag: IsoCountries.flag(countryCode: country.alpha2) ?? "", name: country.name,countryCode : country.alpha2, code: country.calling))
            }
            self.tableView.reloadData()

        }
        else {
            
        }

    }




}

