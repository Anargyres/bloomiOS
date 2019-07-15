//
//  AccountListViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 10/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class AccountListViewController: UIViewController {
    
    var window: UIWindow?
    var token: String!

    @IBOutlet var deconnexionButton: UIButton!
    @IBOutlet var personnalInformationsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My account"
        personnalInformationsButton = setBorder(button: personnalInformationsButton)
        deconnexionButton = setBorder(button: deconnexionButton)
    }
    
    @IBAction func handlePersonnalInformationsPress(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.personnalInformationsButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in UIView.animate(withDuration: 0.1) {
            self.personnalInformationsButton.transform = CGAffineTransform.identity
            AccountServices.default.getUserInfo(token: self.token, completion: { res in
                let next = PersonnalInformationsViewController()
                next.manager = res
                self.navigationController?.pushViewController(next, animated: true)
            })
        }})
    }   
    
    
    @IBAction func handleDeconnexionPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.deconnexionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in UIView.animate(withDuration: 0.1) {
            self.deconnexionButton.transform = CGAffineTransform.identity
            
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            let w = UIWindow(frame: UIScreen.main.bounds)
            w.rootViewController = navigationController
            w.makeKeyAndVisible()
            self.window = w
            }})
    }
    
    func setBorder(button: UIButton) -> UIButton{
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        button.layer.shadowOpacity = 0.5
        
        return button
    }
}
