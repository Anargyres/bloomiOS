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
    
    public func login(email: String, password: String, completion: @escaping (String) -> Void) {
        
        let parameters: Parameters = ["email": email, "password": password]
        
        Alamofire.request("http://localhost:3000/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
            guard let json = res.result.value as? [String: Any],
            let error = json["error"] as? String
            else {
                completion("ok")
                return
            }
            completion(error)
        }
        
    }
}


