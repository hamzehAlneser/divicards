//
//  ProfileRepositry.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 10/06/2021.
//

import UIKit
import Alamofire
struct ProfileRepositry {
    var serviceConstants = ServiceConstants()
    
    func UpdateInfoRequest(id : String, fName : String,lName : String, phone : String, gender : String, dob : String,changePassword : String, completion: @escaping(_ response : ProfileResponse?) -> ()) {
        let parameters = ["customers_id" : id, "customers_firstname" : fName, "customers_lastname" : lName,"customers_telephone" : phone,"customers_gender" : gender, "customers_dob" : dob, "changePassword" : changePassword  ]
        AF.request(serviceConstants.UpdateUserInfoUrl, method: .post, parameters: parameters , encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
            guard let data = data.data else {return}
            
            do{
                let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
                completion(response)
                
            }
            catch{
                completion(nil)
            }
            
        }

    }
}
