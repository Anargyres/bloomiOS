//
//  PromotionalCode.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation
import UIKit

public class PromotionalCode {
    
    var idEvent: String
    var name: String
    var price: String
    var quantity: String
    
    init(idEvent: String, name: String, price: String, quantity: String){
        self.idEvent =  idEvent
        self.name = name
        self.price = price
        self.quantity = quantity
    }
    
    
    func toJSON() -> [String: Any] {
        return [
            "idEvent": idEvent as Any,
            "name": name as Any,
            "price": price as Any,
            "quantity": quantity as Any,
        ]
    }
    
}



