//
//  AddTicketsViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 11/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

protocol UpdateEventsProtocol: class {
    func updateEvents(events: [Event])
}

class AddTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventID: String!
    var token: String!
    var tickets: [Ticket] = []
    weak var pressDelegate: UpdateEventsProtocol?
    @IBOutlet var tableView: UITableView!
    
    let cellIdentifier = "cellIdentifier"
    
    class func newInstance(eventID: String, token: String) -> AddTicketsViewController {
        let evc = AddTicketsViewController()
        evc.eventID = eventID
        evc.token = token
        
        return evc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Add tickets"
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAddTicket))
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TicketTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TicketTableViewCell
        
        cell.name.text = tickets[indexPath.row].name
        cell.price.text = String(tickets[indexPath.row].price)
        cell.quantity.text = String(tickets[indexPath.row].quantity)
        
        return cell
    }
    
    @objc func handleAddTicket() {
        let next = AddTicketFormViewController()
        next.pressDelegate = self
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func handleSubmitEvent(_ sender: Any) {
        TicketServices.default.putTicket(tickets: tickets)
        EventServices.default.getEvents(token: self.token) { responseEvent in
            let events = responseEvent as [Event]

            self.pressDelegate?.updateEvents(events: events)
            for vc in self.navigationController!.viewControllers {
                if let evc = vc as? EventViewController {
                    evc.events = events
                    self.navigationController?.popToViewController(evc, animated: true)
                }
            }
        }
    }
}


extension AddTicketsViewController: AddTicketProtocol {
    func addTicket(name: String, quantity: String, price: String) {
        tickets.append(Ticket(idEvent: eventID, name: name, price: Double(price)!, quantity: Int(quantity)!))
        tableView.reloadData()
    }
}
