//
//  AddToOrdersResponse.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 20/07/2021.
//

struct AddToOrdersResponse:Decodable {
    var success: String
    var data : [JSONAny]
    var customer_id : Int?
    var message: String
}
