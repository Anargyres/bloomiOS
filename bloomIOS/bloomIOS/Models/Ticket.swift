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
    var isUsed: Bool

    
    init(idEvent: String, name: String, price: Double, quantity: Int, isUsed: Bool){
        self.idEvent =  idEvent
        self.name = name
        self.price = price
        self.quantity = quantity
        self.isUsed = isUsed
    }
    
    
    /*

    func toJSON() -> [String: Any] {
        return [
            "title": title as Any,
            "description": description as Any,
            "latitude": latitude as Any,
            "longitude": longitude as Any,
            "promotionalCode": promotionalCode as Any,
        ]
    }
 */
}



