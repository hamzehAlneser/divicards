//
//  LoginRepositry.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 09/05/2021.
//

import Alamofire

struct LoginRepositry {

    var serviceConstants = ServiceConstants()
    
    func loginRequest(url : String, email : String, password : String, completion: @escaping(_ response : LoginResponse?) -> ()) {
        let parameters = ["email" : email, "password" : password]
        AF.request(url, method: .post, parameters: parameters , encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil).response { (data) in
            guard let data = data.data else {return}
            
            do{
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(response)
                
            }
            catch{
                completion(nil)
            }
            
        }

    }
    
}

