//
//  ServiceConstants.swift
//  divicards
//
//  Created by Hamzeh Abdul kareem on 10/05/2021.
//

import UIKit
import Alamofire
struct ServiceConstants {
    let loginUrl = "http://divicards2.sensitivetime.com//api/processlogin"
    let RegisterUrl = "http://divicards2.sensitivetime.com//api/processregistration"
    let categoriesUrl = "http://divicards2.sensitivetime.com//api/allcategories"
    let ProductsUrl = "http://divicards2.sensitivetime.com//api/getallproducts"
    let UpdateUserInfoUrl = "http://divicards2.sensitivetime.com//api/updatecustomerinfo"
func getHeaders() -> HTTPHeaders{
    let headers : HTTPHeaders = [
        "consumer-key" : "6801303c908569e8466efaac4d0cce85",
        "consumer-secret" : "268e7de2afe718c957e77cadbf25ff86",
        "consumer-ip" : getIPAddress()!,
        "consumer-nonce" : generateUniqueNonce(),
        "consumer-device-id" : UIDevice.current.identifierForVendor!.uuidString


    ]
    
    return headers
}

func getIPAddress() -> String? {
    var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
        }
    
    func generateUniqueNonce() -> String{
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789./?!%^-+_=!@#$%^&*()"
           let len = UInt32(letters.length)

           var randomString = ""

           for _ in 0 ..< len {
               let rand = arc4random_uniform(len)
               var nextChar = letters.character(at: Int(rand))
               randomString += NSString(characters: &nextChar, length: 1) as String
           }

           return randomString
    }
            
}
