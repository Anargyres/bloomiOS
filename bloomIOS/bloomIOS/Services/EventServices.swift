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
    

    public func getEvents(completion: @escaping ([String: Any]) -> Void) {
        Alamofire.request("http://localhost:3000/events").responseJSON { (res) in
            
            print(res)
        }
    }
    
    public func serialize(_ value: Any) -> Data? {
        if JSONSerialization.isValidJSONObject(value) {
            return try? JSONSerialization.data(withJSONObject: value, options: [])
        }
        else {
            return String(describing: value).data(using: .utf8)
        }
    }
    
    public func putEvents(event: Event){
 
        let imageData = event.image.jpegData(compressionQuality: 0.2)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in event.toJSON() {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            multipartFormData.append(imageData!, withName: "fileset",fileName: event.title + ".jpg", mimeType: "image/jpg")
        }, to:"http://localhost:3000/events")
        { result in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
    }
}


