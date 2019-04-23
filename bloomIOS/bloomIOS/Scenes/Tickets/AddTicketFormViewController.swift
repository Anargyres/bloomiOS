//
//  AddTicketFormViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 12/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit


protocol AddTicketProtocol {
    func addTicket(name: String, quantity: String, price: String)
}

class AddTicketFormViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    var pressDelegate: AddTicketProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func createTicketButton(_ sender: Any) {
            pressDelegate?.addTicket(name: nameTextField.text!, quantity: quantityTextField.text!, price: priceTextField.text!)
            navigationController?.popViewController(animated: true)
    }
    



}
