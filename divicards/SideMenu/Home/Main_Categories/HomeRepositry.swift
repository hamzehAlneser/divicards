//
//  HomeRepositry.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 12/05/2021.
//

import UIKit
import Alamofire
struct HomeRepositry {
    let serviceConstants = ServiceConstants()
    func homeCategoriesRequest(completion: @escaping(_ response : HomeCategoriesResponse?) -> ()) {
        let parameters = ["language_id" : 1]
        AF.request(serviceConstants.categoriesUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
            guard let data = data.data else {return}
            
            do{
                let response = try JSONDecoder().decode(HomeCategoriesResponse.self, from: data)
                completion(response)
                
            }
            catch{
                completion(nil)
            }
            
        }
}
}
