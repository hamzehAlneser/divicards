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
    var products_id : String
    var products_image : String
    var products_price : Double
    var products_name : String
    var products_quantity : String
    var currency : String
    var products_description : String
    var categories : [CategoryDataForProduct]
}

struct CategoryDataForProduct:Decodable {
    var categories_id : String
    var categories_name : String
    var categories_image : String
    var categories_icon : String
    var parent_id : String
}


