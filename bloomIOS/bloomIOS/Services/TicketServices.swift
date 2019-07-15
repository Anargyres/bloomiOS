//
//  TicketServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 25/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Alamofire

public class TicketServices {
    
    public static let `default` = TicketServices()
    
    public func putTicket(tickets: [Ticket]) {
        
        tickets.forEach({ ticket in
            
            let parameters: Parameters = [
                "idEvent": ticket.idEvent,
                "name": ticket.name,
                "price": ticket.price,
                "quantity": ticket.quantity
            ]
            
            Alamofire.request("https://lit-sands-88177.herokuapp.com/tickets", method: .post, parameters: parameters, encoding: JSONEncoding.default)

        });
    }
    
    public func setPromotionalCode(promotionalCode: PromotionalCode){
        
        let parameters: Parameters = [
            "idEvent": promotionalCode.idEvent,
            "name": promotionalCode.name,
            "price": promotionalCode.price,
            "quantity": promotionalCode.quantity
        ]
        
        Alamofire.request("https://lit-sands-88177.herokuapp.com/tickets/promotionalCode", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    }
}


