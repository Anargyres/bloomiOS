//
//  Ticket.swift
//  bloomIOS
//
//  Created by Tristan Luong on 12/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation
import UIKit

public class Ticket {
    
    var idEvent: String
    var name: String
    var price: Double
    var quantity: Int

    init(idEvent: String, name: String, price: Double, quantity: Int){
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



