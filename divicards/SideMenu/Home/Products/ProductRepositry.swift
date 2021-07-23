//
//  ProductRepositry.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 09/06/2021.
//

import UIKit
import Alamofire
struct ProductRepositry {
    let serviceConstants = ServiceConstants()
    func productsRequest(catId : String,completion: @escaping(_ response : ProductResponse?) -> ()) {
        let parameters = ["categories_id" : catId,
                          "language_id" : "1",
                          "type" : "a to z",
                          "currency_code" : "USD"]
        

        AF.request(serviceConstants.ProductsUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
            guard let data = data.data else {return}
            
            do{
                let response = try JSONDecoder().decode(ProductResponse.self, from: data)
                completion(response)
                
            }
            catch{
                print("Error is \(error)")
                completion(nil)
            }
            
        }
        
        }

}

