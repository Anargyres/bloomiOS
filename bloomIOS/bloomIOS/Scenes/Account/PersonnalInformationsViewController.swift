//
//  PersonnalInformationsViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 10/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class PersonnalInformationsViewController: UIViewController {

    var manager: Manager!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 7
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
        emailTextField.text = manager.email
        firstNameTextField.text = manager.firstName
        lastNameTextField.text = manager.lastName
        phoneNumberTextField.text = manager.phoneNumber
    }
    
    @IBAction func handleSaveButtonPress(_ sender: Any) {
        
        if(verifForm() == false){
            AccountServices.default.updateUserInfo(id: manager.idManager, email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text, lastName: lastNameTextField.text, phoneNumber: phoneNumberTextField.text)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func verifForm() -> Bool {
        
        var error = false
        
        guard
        let email = emailTextField.text,
        let password = passwordTextField.text,
        let confirmPassword = confirmPasswordTextField.text
        else {
            return true
        }
        
        print(password.count)
        if(email.count == 0){
            print(email)
            emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.cornerRadius = 10
            error = true
        } else {
            emailTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.cornerRadius = 10
        }
        if(password.count == 0){
            print("No password")

            passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.cornerRadius = 10
            error = true
        } else {
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.cornerRadius = 10
        }
        if(confirmPassword.count == 0){
            confirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            confirmPasswordTextField.layer.borderWidth = 3
            confirmPasswordTextField.layer.cornerRadius = 10
            error = true
        } else {
            confirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            confirmPasswordTextField.layer.borderWidth = 1
            confirmPasswordTextField.layer.cornerRadius = 10
        }
        if(password != confirmPassword){
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.cornerRadius = 10
            confirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            confirmPasswordTextField.layer.borderWidth = 1
            confirmPasswordTextField.layer.cornerRadius = 10
            error = true
        } else {
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.cornerRadius = 10
            confirmPasswordTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            confirmPasswordTextField.layer.borderWidth = 1
            confirmPasswordTextField.layer.cornerRadius = 10
        }
        
        return error
    }
}
