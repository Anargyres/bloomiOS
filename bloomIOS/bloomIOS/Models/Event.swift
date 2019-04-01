//
//  Event.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Foundation
import UIKit

public class Event {
    
    var title: String
    var description: String
    var latitude: String
    var longitude: String
    var promotionalCode: String
    var image: UIImage
    
    init(title: String, description: String, latitude: String, longitude: String, promotionalCode: String, image: UIImage) {
        self.title = title
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.promotionalCode = promotionalCode
        self.image = image
    }
    
    
    func toJSON() -> [String: Any] {
        return [
            "title": title as Any,
            "description": description as Any,
            "latitude": latitude as Any,
            "longitude": longitude as Any,
            "promotionalCode": promotionalCode as Any,
        ]
    }
}


