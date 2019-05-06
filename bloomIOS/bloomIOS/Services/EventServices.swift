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
    

    public func getEvents(completion: @escaping ([Event]) -> Void) {
        
        var allEvents = [Event]()

        Alamofire.request("http://localhost:3000/events").responseJSON { (res) in
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
                let coord = event["coord"] as? [String: Any],
                let latitude = coord["latitude"] as? String,
                let longitude = coord["longitude"] as? String
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
    
    public func putEvents(event: Event, completion: @escaping (String) -> Void) {

        let imageData = event.UIImage?.jpegData(compressionQuality: 0.2)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in event.toJSON() {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(imageData!, withName: "fileset",fileName: event.title + ".jpg", mimeType: "image/jpg")
        }, to:"http://localhost:3000/events")
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
            multipartFormData.append(imageData!, withName: "fileset",fileName: event.title + ".jpg", mimeType: "image/jpg")
        }, to:"http://localhost:3000/events/update/\(title)")
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
}


