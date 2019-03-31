//
//  EventServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//


public class EventServices {
    
    public static let `default` = EventServices()
    

    public func getEvents(completion: @escaping ([String: Any]) -> Void) {
        Alamofire.request("http://localhost/events").responseJSON { (res) in
            
            print(res)
        }
    }
    
    /**
     guard let url = URL(string: "https://moc-3a-movies.herokuapp.com/") else {
     return
     }
     let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
     guard let d = data,
     let json = try? JSONSerialization.jsonObject(with: d, options: .allowFragments),
     let m = json as? [[String: Any]] else {
     return
     }
     //let movies = m.compactMap { return Movie(json: $0) } // flatMap
     let movies = m.compactMap({ (elem) -> Movie? in
     return Movie(json: elem)
     })
     completion(movies) // Execute callback / closure
     }
     task.resume()
     */
}


