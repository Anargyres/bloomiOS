//
//  LoginViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 11/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var window: UIWindow?
    
    @IBOutlet var loginImageView: UIImageView!
    @IBOutlet var loginButto: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var registerLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.errorLabel.isHidden = true
        self.view.backgroundColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        self.navigationItem.title = "Login"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleRegisterPress))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(gestureRecognizer)
        loginButto.layer.cornerRadius = 7
        loginButto.layer.borderWidth = 1
        loginButto.layer.borderColor = UIColor.black.cgColor

    }


    @IBAction func handleConnectionPress(_ sender: Any) {
        LoginServices.default.login(email: emailTextField.text!, password: passwordTextField.text!) { responseLogin in
            self.errorLabel.isHidden = false
            self.errorLabel.text = responseLogin["error"] as? String
                        
            if(responseLogin["token"] != nil ){
                self.errorLabel.isHidden = true
                EventServices.default.getEvents(token: responseLogin["token"] as! String) { responseEvent in
                    let events = responseEvent as [Event]
                    let layout = UICollectionViewFlowLayout()
                    let eventViewController = EventViewController(collectionViewLayout: layout)
                    eventViewController.events = events
                    eventViewController.token = responseLogin["token"] as? String
                    
                    let navigationController = UINavigationController(rootViewController: eventViewController)
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.loginButto.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    }, completion: { _ in UIView.animate(withDuration: 0.1) {
                        self.loginButto.transform = CGAffineTransform.identity
                        let w = UIWindow(frame: UIScreen.main.bounds)
                        w.rootViewController = navigationController
                        w.makeKeyAndVisible()
                        self.window = w
                    }})
                }
            }
        }
    }
    
    @objc func handleRegisterPress(){
        let next = RegisterViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}
