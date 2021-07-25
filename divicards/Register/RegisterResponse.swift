//
//  RegisterResponse.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 16/05/2021.
//

import UIKit
struct RegisterResponse : Decodable {
    var success : String
    var data : [RegisterData]
    var message : String

}
struct RegisterData:Decodable {
    var id : String
    var first_name : String
    var last_name : String
    var gender : String
    var email : String
    var phone : String
    var password : String
}
