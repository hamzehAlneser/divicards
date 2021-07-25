//
//  HistoryRepository.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 20/07/2021.
//

import UIKit
import Alamofire
struct HistoryRepository {
    let serviceConstants = ServiceConstants()
    func HistoryRequest(completion: @escaping(_ response : HistoryResponse?) -> ()) {
        let parameters = ["currency_code" : "JOD",
                          "language_id" : "1",
                          "customers_id" : UserDefaults.standard.string(forKey: "UserId")!]
        
print(UserDefaults.standard.string(forKey: "UserId")!)
        AF.request(serviceConstants.HistoryUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
            guard let data = data.data else {return}
            
            do{
                print(data)
                let dataString = String(data: data, encoding: .utf8)
                print(dataString)
                let jsondata = dataString?.data(using: .utf8)
                let response = try JSONDecoder().decode(HistoryResponse.self, from: jsondata!)
                
                completion(response)
                
            }
            catch{
                print("Error is \(error)")
                completion(nil)
            }
            
        }
        
        }

}
