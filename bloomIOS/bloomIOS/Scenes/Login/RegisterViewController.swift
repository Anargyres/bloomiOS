//
//  RegisterViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 06/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Register"

    }


    @IBAction func handleRegisterPress(_ sender: Any) {
        if(emailTextField.text!.count > 0){
            RegisterServices.default.register(email: emailTextField.text!)
            
            let alert = UIAlertController(title: "Register complete", message: "We have send you an email with your provisional password ! Please check them :)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.navigationController!.popToRootViewController(animated: true)
            }))
            self.present(alert, animated: true)
        } else {
            self.emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            self.emailTextField.layer.borderWidth = 1
            self.emailTextField.layer.cornerRadius = 10
        }
    }
    
 
    

    

    

}
