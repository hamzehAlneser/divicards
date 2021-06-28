//
//  Country.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 10/05/2021.
//

import UIKit
struct LoginResponse : Decodable {
    var success : String
    var data : [data]
    var message : String
}
struct data:Decodable {
    var id : String
    var role_id : String
    var first_name : String
    var last_name : String
    var gender : String
    var password : String
    var phone : String
    var email : String
}
