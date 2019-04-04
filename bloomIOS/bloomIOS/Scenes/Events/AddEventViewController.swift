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
        
        self.view.backgroundColor = #colorLiteral(red: 0.1121567198, green: 0.1747886778, blue: 0.387154981, alpha: 1)
        self.navigationItem.title = "Create event"
        
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
        
        let event = Event(title: title, description: description, latitude: latitude, longitude: longitude, promotionalCode: promotionalCode, UIImage: image, SImage: nil)
        EventServices.default.putEvents(event: event)
        
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
