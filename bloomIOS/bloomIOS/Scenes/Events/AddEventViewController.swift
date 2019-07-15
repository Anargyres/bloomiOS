//
//  AddEventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import Alamofire

class AddEventViewController: UIViewController {
    
    var event: Event?
    var token: String!
    
    @IBOutlet var handleAddEventButton: UIButton!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var latitudeLabel: UITextField!
    @IBOutlet var longitudeLabel: UITextField!
    @IBOutlet var promotionalCodeLabel: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    class func newInstance(event: Event?, token: String) -> AddEventViewController{
        let dvc = AddEventViewController()
        dvc.event = event
        dvc.token = token
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        self.navigationItem.title = "Create event"
        
        if(event != nil){
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(self.handleDetailEventPress))
        }
        handleAddEventButton.layer.cornerRadius = 10
        handleAddEventButton.layer.borderWidth = 1
        handleAddEventButton.layer.borderColor = UIColor.black.cgColor
        
        self.descriptionLabel.layer.borderWidth = 1
        self.descriptionLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.descriptionLabel.layer.cornerRadius = 7
        self.descriptionLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.onClickImageView))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imagePicker.delegate = self
        
        imageView.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        imageView.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.masksToBounds = false
        // DetailEventViewController
        
        if(event != nil){
            self.navigationItem.title = event?.title
            self.handleAddEventButton.setTitle("Update", for: .normal)
            self.titleLabel.text = event?.title
            self.descriptionLabel.text = event?.description
            self.latitudeLabel.text = event?.latitude
            self.longitudeLabel.text = event?.longitude
            self.promotionalCodeLabel.text = event?.promotionalCode
            
            guard let imageName = event?.SImage
            else {
                return
            }
            
            let requestUrl = "https://lit-sands-88177.herokuapp.com/images/\(imageName)"
            
            Alamofire.request(requestUrl, method: .get)
                .responseData(completionHandler: { (responseData) in
                    self.imageView.image = UIImage(data: responseData.data!)
            })
        }
    }
    
    @objc func onClickImageView(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)

    }
    
    @objc func handleDetailEventPress() {
        EventServices.default.getResumeTicket(eventTitle: (event?.title)!, completion: { res in
            let aervc = AllEventsResumeViewController()
            aervc.tickets = res
            self.navigationController?.pushViewController(aervc, animated: true)
        })
    }
 
    @IBAction func createButton(_ sender: UIButton) {

        guard
        let title = self.titleLabel.text,
        let description = self.descriptionLabel.text,
        let latitude = self.latitudeLabel.text,
        let longitude = self.longitudeLabel.text,
        let promotionalCode = self.promotionalCodeLabel.text,
        let image = self.imageView.image
        else {
            return
        }
        
        if(verifForm() == false){
            
            let newEvent = Event(title: title, description: description, latitude: latitude, longitude: longitude, promotionalCode: promotionalCode, UIImage: image, SImage: nil)
            
            if(event == nil){
                EventServices.default.putEvents(token: self.token, event: newEvent, completion: { res in
                    let next = AddTicketsViewController.newInstance(eventID: res, token: self.token)
                    self.navigationController?.pushViewController(next, animated: true)
                })
            } else {
                EventServices.default.updateEvent(event: newEvent, title: (event?.title)!)
            }
        }
    }
    
    func verifForm() -> Bool {
        
        var error = false
        
        guard
        let title = self.titleLabel.text,
        let description = self.descriptionLabel.text,
        let latitude = self.latitudeLabel.text,
        let longitude = self.longitudeLabel.text,
        let promotionalCode = self.promotionalCodeLabel.text
        else {
            return true
        }
        
        if(title.count <= 0){
            self.titleLabel.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.titleLabel.layer.borderWidth = 1
            self.titleLabel.layer.cornerRadius = 10
            error = true
        } else {
            self.titleLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.titleLabel.layer.borderWidth = 1
        }
        if(description.count == 0){
            self.descriptionLabel.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.descriptionLabel.layer.borderWidth = 1
            self.descriptionLabel.layer.cornerRadius = 10
            error = true
        } else {
            self.descriptionLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.descriptionLabel.layer.borderWidth = 1
        }
        if(latitude.count == 0){
            self.latitudeLabel.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.latitudeLabel.layer.borderWidth = 1
            self.latitudeLabel.layer.cornerRadius = 10
            error = true
        } else {
            self.latitudeLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.latitudeLabel.layer.borderWidth = 1
        }
        if(longitude.count == 0){
            self.longitudeLabel.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.longitudeLabel.layer.borderWidth = 1.0
            self.longitudeLabel.layer.cornerRadius = 10
            error = true
        } else {
            self.longitudeLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.longitudeLabel.layer.borderWidth = 1
        }
        if(promotionalCode.count == 0){
            self.promotionalCodeLabel.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.promotionalCodeLabel.layer.borderWidth = 1.0
            self.promotionalCodeLabel.layer.cornerRadius = 10
            error = true
        } else {
            self.promotionalCodeLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.promotionalCodeLabel.layer.borderWidth = 1
        }
        
        return error
    }
}


extension AddEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
}
