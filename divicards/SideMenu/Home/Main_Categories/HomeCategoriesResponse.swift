//
//  HomeCategoriesResponse.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 12/05/2021.
//

import UIKit
struct HomeCategoriesResponse : Decodable {
    var success : String
    var data : [CategoryData]
    var message : String
    var categories : Int?
}
struct CategoryData:Decodable {
    var categories_id : String
    var categories_name : String
    var parent_id : String
    var image : String
    var icon : String
    var total_products : String
}
