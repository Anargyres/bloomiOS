//
//  RegisterServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 06/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Alamofire

public class RegisterServices {
    
    public static let `default` = RegisterServices()
    
    public func register(email: String, completion: @escaping (String) -> Void) {
        
        let parameters: Parameters = ["email": email]
            
        Alamofire.request("http://localhost:3000/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (res) in
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


