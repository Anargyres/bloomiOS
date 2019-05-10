//
//  AccountListViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 10/05/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class AccountListViewController: UIViewController {

    var token: String!

    @IBOutlet var personnalInformationsButton: UIButton!
    @IBOutlet var eventHistoryButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "My account"
        personnalInformationsButton = setBorder(button: personnalInformationsButton)
        eventHistoryButton = setBorder(button: eventHistoryButton)
    }
    
    
    func setBorder(button: UIButton) -> UIButton{
        button.layer.borderWidth = 1.0
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        
        return button
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
