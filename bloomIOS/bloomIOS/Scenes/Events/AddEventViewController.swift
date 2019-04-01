//
//  AddEventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var latitudeLabel: UITextField!
    @IBOutlet weak var longitudeLabel: UITextField!
    @IBOutlet weak var promotionalCodeLabel: UITextField!
    
    
    class func newInstance() -> AddEventViewController{
        let dvc = AddEventViewController()
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create event"


    }


    @IBAction func createButton(_ sender: UIButton) {
        
        guard
        let title = self.titleLabel.text,
        let description = self.descriptionLabel.text,
        let latitude = self.latitudeLabel.text,
        let longitude = self.longitudeLabel.text,
        let promotionalCode = self.promotionalCodeLabel.text
        else {
            return
        }
        
        let event = Event(title: title, description: description, latitude: latitude, longitude: longitude, promotionalCode: promotionalCode)
        EventServices.default.putEvents(event: event)
        
    }
}
