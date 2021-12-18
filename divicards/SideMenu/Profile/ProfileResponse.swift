//
//  ProfileResponse.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 10/06/2021.
//

import UIKit
struct ProfileResponse : Decodable {
    var success : String
    var data : [UserData]
    var message : String
}
struct UserData:Decodable {
    var id : Int
    var role_id : Int
    var first_name : String
    var last_name : String
    var gender : String
    var phone : String
}
