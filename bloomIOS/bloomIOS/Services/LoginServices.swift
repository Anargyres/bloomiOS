//
//  RegisterServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 06/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Alamofire

public class LoginServices {
    
    public static let `default` = LoginServices()
    
    public func login(email: String, password: String, completion: @escaping ([String: Any]) -> Void) {
        
        let parameters: Parameters = ["email": email, "password": password]
        
        Alamofire.request("https://lit-sands-88177.herokuapp.com/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            guard let json = res.result.value as? [String: Any]
            else {
                return
            }
            completion(json)
        }
    }
}


