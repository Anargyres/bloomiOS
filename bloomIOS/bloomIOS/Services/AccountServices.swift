//
//  AccountServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 10/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation
import Alamofire

public class AccountServices {
    
    public static let `default` = AccountServices()
    
    public func getUserInfo(token: String, completion: @escaping (Manager) -> Void) {

        let headers: HTTPHeaders = [
            "x-access-token": token,
            ]
        
        Alamofire.request("https://lit-sands-88177.herokuapp.com/managers", encoding: JSONEncoding.default, headers: headers).responseJSON { (res) in
            guard let json = res.result.value as? [String: Any],
            let manager = json["manager"] as? [String: Any],
            let id = manager["_id"] as? String,
            let email = manager["email"] as? String,
            let password = manager["password"] as? String,
            let firstName = manager["firstName"] as? String,
            let lastName = manager["lastName"] as? String,
            let phoneNumber = manager["phoneNumber"] as? String
            else {
                return
            }
            let newManager = Manager.init(idManager: id, email: email, password: password, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
            completion(newManager)
        }
    }
    
    public func updateUserInfo(id: String, email: String, password: String, firstName: String?, lastName: String?, phoneNumber: String?) {
        
        let parameters: Parameters = [
            "email": email,
            "password": password,
            "firstName": firstName!,
            "lastName": lastName!,
            "phoneNumber": phoneNumber!
        ]
        
        Alamofire.request("https://lit-sands-88177.herokuapp.com/managers/\(id)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
}
