//
//  AddTicketFormViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 12/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit


protocol AddTicketProtocol {
    func addTicket(name: String, quantity: Int, price: String)
}

class AddTicketFormViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var createTicketButton: UIButton!
    var pressDelegate: AddTicketProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        createTicketButton.layer.cornerRadius = 10
        createTicketButton.layer.masksToBounds = true
        createTicketButton.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        createTicketButton.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        createTicketButton.layer.shadowOpacity = 0.5
    }
    
    
    @IBAction func createTicketButton(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure", message: "You will not be able to update this later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            self.pressDelegate?.addTicket(name: self.nameTextField.text!, quantity: Int(self.quantityTextField.text!)!, price: self.priceTextField.text!)
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)

    }
    



}
