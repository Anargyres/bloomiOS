//
//  EventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Events"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAddEvent))
        self.view.backgroundColor = #colorLiteral(red: 0.1121567198, green: 0.1747886778, blue: 0.387154981, alpha: 1)
    }
    
    @objc func handleAddEvent() {
        let next = AddEventViewController.newInstance()
        self.navigationController?.pushViewController(next, animated: true)
    }

}
