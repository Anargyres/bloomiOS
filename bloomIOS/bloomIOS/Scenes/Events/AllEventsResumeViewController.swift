//
//  AddTicketsViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 11/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit


class AllEventsResumeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tickets: [Ticket] = []
    var totalSellsValue = 0
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalSellsLabel: UILabel!
    @IBOutlet var totalPromotionalCodeLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Resume tickets sells"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TicketTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.layer.masksToBounds = true
        tableView.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        tableView.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        tableView.layer.shadowOpacity = 0.5
        
        var totalSellsValue = 0
        
        tickets.forEach({ticket in
            guard let quantityUpdated = Int(ticket.quantityUpdated!) as? Int,
            let quantity = Int(ticket.quantity) as? Int,
            let price = Int(ticket.price) as? Int
            else {
                return
            }
            totalSellsValue += (quantity - quantityUpdated) * price
        })
        
        EventServices.default.getPromotionalCodeReduction(idEvent: tickets[0].idEvent , completion: { res in
            self.totalSellsLabel.text = String(totalSellsValue)
            self.totalPromotionalCodeLabel.text = String(res)
            self.totalLabel.text = String(Int(totalSellsValue) - res)
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TicketTableViewCell
        
        cell.name.text = tickets[indexPath.row].name
        cell.price.text = tickets[indexPath.row].price
        cell.quantity.text = String(tickets[indexPath.row].quantityUpdated!) + "/" + String(tickets[indexPath.row].quantity)
        totalSellsValue = Int(tickets[indexPath.row].quantity) - Int(tickets[indexPath.row].quantityUpdated!)
        
        return cell
    }
}

