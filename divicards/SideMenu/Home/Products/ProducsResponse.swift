//
//  ProducsResponse.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 09/06/2021.
//

import UIKit
struct ProductResponse : Decodable {
    var success : String
    var product_data : [ProductData]
    var message : String
    var total_record : Int?
}

struct ProductData : Decodable {
    var products_id : Int
    var products_image : String
    var products_price : String
    var products_name : String
    var products_quantity : Int
    var currency : String
    var products_description : String
    var categories : [CategoryDataForProduct]
    var defaultStock : Int
}

struct CategoryDataForProduct:Decodable {
    var categories_id : Int
    var categories_name : String
    var categories_image : String
    var categories_icon : String
    var parent_id : Int
}


