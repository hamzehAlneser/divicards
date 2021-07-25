//
//  FinalPageRepository.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 20/07/2021.
//

import UIKit
import Alamofire
struct AddToOrdersRepository {
        func AddToOrdersRequest(products_id : Int,products_name : String, price : String, name : String, phone : String , completion: @escaping(_ response : AddToOrdersResponse?) -> ()) {
    let product = Products(products_id: products_id, products_name: products_name, customers_basket_quantity: 1, price: price, final_price: price, attribtes: [])
            let array : [Products] = [ product, ]
                
    let serviceConstants = ServiceConstants()


        var products : [Products] = [product,]

            
            let parameters = ["products":[["products_id":products_id,"products_name":products_name,"customers_basket_quantity":1,"price":price,"final_price":price,"attribtes":[]]],
                          "guest_status":1,
                          "language_id":1,
                          "email":UserDefaults.standard.string(forKey: "UserEmail"),
                          "delivery_firstname":name,
                          "delivery_lastname":name,
                          "customers_telephone":phone,
                          "delivery_street_address":"cxgf",
                          "totalPrice":price,
                          "currency_code":"USD",
                          "total_tax":0.00,
                          "is_coupon_applied":0,
                          "payment_method":"cod",
                          "delivery_suburb":"ioo",
                          "delivery_city":"io",
                          "delivery_postcode":"678",
                          "delivery_zone":"678",
                          "delivery_country":"jo",
                          "billing_firstname":name,
                          "billing_lastname":name,
                          "billing_street_address":"ty",
                          "billing_suburb":"ty",
                          "billing_city":"ty",
                          "billing_postcode":"56",
                          "billing_zone":"56",
                          "billing_country":"ty",
                          "delivery_phone":phone,
                          "billing_phone":phone,
                          "shipping_cost":"2.00",
                          "shipping_method":"FlateRate"] as [String : Any]
        print(parameters)


        let request = AF.request(serviceConstants.AddToOrdersUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: serviceConstants.getHeaders(), interceptor: nil, requestModifier: nil)
        request.validate()
        print(request)
            request.responseJSON(completionHandler: { (response) in
                
  

            guard let data = response.data else {return}
            do{
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
                let response = try JSONDecoder().decode(AddToOrdersResponse.self, from: data)

                completion(response)

            }
            catch{
                print(error)
                completion(nil)
            }
            print(response.error)
        }

    )}

}

        
        
        

struct Products:Codable {
    var products_id : Int
    var products_name : String
    var customers_basket_quantity : Int
    var price : String
    var final_price : String
    var attribtes : [JSONAny]
    
}

