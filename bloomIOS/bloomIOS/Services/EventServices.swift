//
//  EventServices.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import Alamofire

public class EventServices {
    
    public static let `default` = EventServices()
    
    public func getEvents(token: String, completion: @escaping ([Event]) -> Void) {
        
        var allEvents = [Event]()
        
        let headers: HTTPHeaders = [
            "x-access-token": token,
        ]

        Alamofire.request("https://lit-sands-88177.herokuapp.com/events", headers: headers).responseJSON { (res) in
            guard let events = res.result.value as? [[String:Any]]
            else {
                return
            }
            let eventsCount = events.count
            
            events.forEach({ event in
                guard let title = event["title"] as? String,
                let description = event["description"] as? String,
                let image = event["image"] as? String,
                let promotionalCode = event["promotionalCode"] as? String,
                let latitude = event["latitude"] as? String,
                let longitude = event["longitude"] as? String
                else {
                    return
                }
                let newEvent = Event(title: title, description: description, latitude: latitude, longitude: longitude, promotionalCode: promotionalCode, UIImage: nil, SImage: image)
                    
                allEvents.append(newEvent)
                if(allEvents.count == eventsCount) {
                    completion(allEvents)
                }
            });
            if(events.count == 0){
                completion([])
            }

        }
    }
    
    public func putEvents(token: String, event: Event, completion: @escaping (String) -> Void) {

        let imageData = event.UIImage?.jpegData(compressionQuality: 0.2)
        let headers: HTTPHeaders = [
            "x-access-token": token,
            ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in event.toJSON() {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(imageData!, withName: "fileset",fileName: self.randomString(length: 10) + ".jpg", mimeType: "image/jpg")
        }, to:"https://lit-sands-88177.herokuapp.com/events", headers: headers)
        { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard let json = response.result.value as? [String: Any],
                    let id = json["id"] as? String
                    else {
                        return
                    }
                    completion(id)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    public func updateEvent(event: Event, title: String){
        
        let imageData = event.UIImage?.jpegData(compressionQuality: 0.2)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in event.toJSON() {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(imageData!, withName: "fileset",fileName: title + ".jpg", mimeType: "image/jpg")
        }, to:"https://lit-sands-88177.herokuapp.com/events/update/\(title)")
        { result in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    guard let json = response.result.value as? [String: Any],
                        let id = json["id"] as? String
                        else {
                            return
                    }
                }
                    
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    public func addDate(idEvent: String, date: String){
        let parameters: Parameters = [
            "idEvent": idEvent, 
            "date": date
        ]
        
        Alamofire.request("https://lit-sands-88177.herokuapp.com/events/addDate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
    }
    
    public func getResumeTicket(eventTitle: String, completion: @escaping ([Ticket]) -> Void){
        
        var allTickets = [Ticket]()

        Alamofire.request("https://lit-sands-88177.herokuapp.com/events/resume/\(eventTitle)").responseJSON { (res) in
            print(res)
            guard let tickets = res.result.value as? [[String:Any]]
            else {
                return
            }
            let ticketsCount = tickets.count
            
            tickets.forEach({ ticket in
                let idEvent = ticket["idEvent"] as? String
                let name = ticket["name"] as? String
                let price = ticket["price"] as? String
                let quantity = ticket["quantity"] as? Int
                let quantityUpdated = ticket["quantityUpdated"] as? Int
                
                
                let newTicket = Ticket(idEvent: idEvent!, name: name!, price: price!, quantity: quantity!, quantityUpdated: quantityUpdated!)
            
                allTickets.append(newTicket)
                if(allTickets.count == ticketsCount) {
                    completion(allTickets)
                }
            });
            if(tickets.count == 0){
                completion([])
            }
        }
    }
    
    public func getPromotionalCodeReduction(idEvent: String, completion: @escaping (Int) -> Void){
        Alamofire.request("https://lit-sands-88177.herokuapp.com/events/promotionalCode/\(idEvent)").responseJSON { (res) in
            guard let totalReduce = res.result.value as? [String:Any],
            let numberPromotionalCode = totalReduce["totalReduce"] as? Int
            else {
                return
            }
            completion(numberPromotionalCode)
        }
    }
    
    public func removeEvent(event: Event){
        
        let parameters: Parameters = ["title": event.title]
        Alamofire.request("https://lit-sands-88177.herokuapp.com/events", method: .delete, parameters: parameters, encoding: JSONEncoding.default)
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}


