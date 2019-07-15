//
//  Ticket.swift
//  bloomIOS
//
//  Created by Tristan Luong on 12/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation

public class Manager {
    
    var idManager: String
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(idManager: String, email: String, password: String, firstName: String, lastName: String, phoneNumber: String){
        self.idManager =  idManager
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
}



