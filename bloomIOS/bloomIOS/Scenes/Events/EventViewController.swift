//
//  EventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EventViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var events: [Event]!
    var token: String!
    let cellIdentifier = "cellIdentifier"
    let atvc = AddTicketsViewController()
    
    
    class func newInstance(events: [Event], token: String) -> EventViewController{
        let evc = EventViewController()
        evc.events = events
        evc.token = token
        return evc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Events"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.handleRefreshPress))
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAddEventPress)),
        UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.handleMyAccountPress))
        ]
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        collectionView?.backgroundColor = #colorLiteral(red: 0.925734336, green: 0.9258720704, blue: 0.9544336929, alpha: 1)
        collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! EventCollectionViewCell
        
        cell.delegate = self
        
        cell.titleCollectionView.font = UIFont.boldSystemFont(ofSize: 20)
        cell.titleCollectionView.text = self.events[indexPath.row].title
        cell.titleCollectionView.textAlignment = .center
        
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 7
        
        cell.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 7
        cell.layer.masksToBounds = true
        

        let requestUrl = "https://lit-sands-88177.herokuapp.com/images/\(self.events[indexPath.row].SImage!)"
        
        Alamofire.request(requestUrl, method: .get)
            .responseData(completionHandler: { (responseData) in
                print(responseData)
                cell.imageCollectionView.image = UIImage(data: responseData.data!)
            })
        
        
        // Show details event
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventViewController.onClickItemCollection(sender:)))
        cell.addGestureRecognizer(tap)
        cell.isUserInteractionEnabled = true
        
        // Remove details Event

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            
            // Paysage
            return CGSize(width: (view.frame.width / 3) - 16, height: 250)
        } else {
            // Portrait
            return CGSize(width: (view.frame.width / 2) - 16, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    @objc func handleAddEventPress() {
        let next = AddEventViewController.newInstance(event: nil, token: self.token)
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func handleMyAccountPress(){
        let alvc = AccountListViewController()
        alvc.token = self.token
        self.navigationController?.pushViewController(alvc, animated: true)
    }
    
    @objc func handleRefreshPress(){
        EventServices.default.getEvents(token: token) { responseEvent in
            let newEvents = responseEvent as [Event]
            self.events = newEvents
            self.collectionView.reloadData()
        }
    }
    
    @objc func onClickItemCollection(sender: UITapGestureRecognizer){
        
        if let cell = sender.view, let indexPath = self.collectionView.indexPath(for: cell as! UICollectionViewCell) {
            let next = AddEventViewController.newInstance(event: self.events[indexPath.row], token: self.token)
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
}

extension EventViewController: EventCellDelegate {
    func delete(cell: EventCollectionViewCell) {
        let indexPath = collectionView?.indexPath(for: cell)
        EventServices.default.removeEvent(event: self.events[(indexPath?.row)!])
        self.events.remove(at: (indexPath?.row)!)
        self.collectionView.deleteItems(at: [indexPath!])
    }
}
