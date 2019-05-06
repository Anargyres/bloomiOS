//
//  DetailEventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 04/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import Alamofire

class DetailEventViewController: UIViewController {
    
    var event: Event!
    
    class func newInstance(event: Event) -> DetailEventViewController{
        let evc = DetailEventViewController()
        evc.event = event
        return evc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.925734336, green: 0.9258720704, blue: 0.9544336929, alpha: 1)
        self.navigationItem.title = event.title
        
        let requestUrl = "http://localhost:3000/images/\(event.SImage!)"
        
        
        Alamofire.request(requestUrl, method: .get)
            .responseData(completionHandler: { (responseData) in
                
            })
    }
    
}
