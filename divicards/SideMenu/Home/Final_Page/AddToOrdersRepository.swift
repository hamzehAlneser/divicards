//
//  FinalPageRepository.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 20/07/2021.
//

import UIKit
import Alamofire
struct AddToOrdersRepository {
    let serviceConstants = ServiceConstants()
    func AddToOrdersRequest(products_id : Int,products_name : String, price : String, name : String, phone : String , completion: @escaping(_ response : AddToOrdersResponse?) -> ()) {
        var product = Products(products_id: products_id, products_name: products_name, customers_basket_quantity: 1, price: price, final_price: price, attribtes: [])
        var products : [Products] = [product,]
        

        let parameters = ["products":[product],
                          "guest_status":1,
                          "language_id":1,
                          "email":"anahgfs@ff.ff",
                          "delivery_firstname":"anas",
                          "delivery_lastname":"alfasfus",
                          "customers_telephone":"+962788261243",
                          "delivery_street_address":"cxgf",
                          "totalPrice":"4.30",
                          "currency_code":"USD",
                          "total_tax":0.00,
                          "is_coupon_applied":0,
                          "payment_method":"cod",
                          "delivery_suburb":"ioo",
                          "delivery_city":"io",
                          "delivery_postcode":"678",
                          "delivery_zone":"678",
                          "delivery_country":"jo",
                          "billing_firstname":"ty",
                          "billing_lastname":"ty",
                          "billing_street_address":"ty",
                          "billing_suburb":"ty",
                          "billing_city":"ty",
                          "billing_postcode":"56",
                          "billing_zone":"56",
                          "billing_country":"ty",
                          "delivery_phone":"23234",
                          "billing_phone":"+962788261243",
                          "shipping_cost":"2.00",
                          "shipping_method":"FlateRate"] as [String : Any]


        let request = AF.request(serviceConstants.AddToOrdersUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil)
        request.validate()
        print(request)
        request.responseDecodable { (response: DataResponse<AddToOrdersResponse, AFError>) in

            guard let data = response.data else {return}
            do{
                let response = try JSONDecoder().decode(AddToOrdersResponse.self, from: data)
                completion(response)
                
            }
            catch{
                completion(nil)
            }
            print(response.error)
        }
        
    }

}

        
        
        

struct Products:Decodable {
    var products_id : Int
    var products_name : String
    var customers_basket_quantity = 1
    var price : String
    var final_price : String
    var attribtes : [String]
    
}
