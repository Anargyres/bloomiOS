//
//  LoginViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 11/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet var registerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        self.navigationItem.title = "Login"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleRegisterPress))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(gestureRecognizer)
    }


    @IBAction func handleConnectionPress(_ sender: Any) {
        
        
    }
    
    @objc func handleRegisterPress(){
        let next = RegisterViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }
    
}
