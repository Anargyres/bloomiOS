//
//  AddEventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var latitudeLabel: UITextField!
    @IBOutlet var longitudeLabel: UITextField!
    @IBOutlet var promotionalCodeLabel: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    class func newInstance() -> AddEventViewController{
        let dvc = AddEventViewController()
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        self.navigationItem.title = "Create event"
        
        self.descriptionLabel.layer.borderWidth = 1
        self.descriptionLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.descriptionLabel.layer.cornerRadius = 10
        self.descriptionLabel.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.onClickImageView))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        imagePicker.delegate = self
    }
    
    @objc func onClickImageView(){
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)

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
        
            let event = Event(title: title, description: description, latitude: latitude, longitude: longitude, promotionalCode: promotionalCode, UIImage: image, SImage: nil)
            EventServices.default.putEvents(event: event, completion: { res in
                let next = AddTicketsViewController.newInstance(eventID: res)
                self.navigationController?.pushViewController(next, animated: true)
            })
            

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
