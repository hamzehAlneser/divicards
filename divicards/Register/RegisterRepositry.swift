//
//  NotAMemberRepositry.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 16/05/2021.
//

import UIKit
import Alamofire
struct RegisterRepositry {
    let serviceConstants = ServiceConstants()
    func RegisterRequest(firstName : String,lastname : String,email : String,password : String,phoneNumber : String, gender : String,completion: @escaping(_ response : RegisterResponse?) -> ()) {
        let parameters = ["customers_firstname" : firstName,
                          "customers_lastname" : lastname,
                          "email" : email,
                          "password" : password,
                          "customers_telephone" : phoneNumber,
                          "customers_gender" : gender]

        AF.request(serviceConstants.RegisterUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
//            var a = firstName
//            var b = lastname
//            var c = email
//            var d = password
//            var e = phoneNumber
//            var f = gender
            guard let data = data.data else {return}
            
            do{
                let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(response)
                
            }
            catch{
                completion(nil)
            }
            
        }
}
}
