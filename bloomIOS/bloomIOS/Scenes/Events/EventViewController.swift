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
    let cellIdentifier = "cellIdentifier"
    
    class func newInstance(events: [Event]) -> EventViewController{
        let evc = EventViewController()
        evc.events = events
        return evc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Events"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.handleAddEvent))
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
        
        cell.titleCollectionView.font = UIFont.boldSystemFont(ofSize: 20)
        cell.titleCollectionView.text = self.events[indexPath.row].title
        cell.titleCollectionView.textAlignment = .center
        
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = #colorLiteral(red: 0.008968460207, green: 0.02003048991, blue: 0.1091370558, alpha: 1)
        cell.layer.shadowOffset = CGSize(width: 5.0, height: -5.0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        

        let requestUrl = "http://localhost:3000/images/\(self.events[indexPath.row].SImage!)"
        
        
        Alamofire.request(requestUrl, method: .get)
            .responseData(completionHandler: { (responseData) in
                cell.imageCollectionView.image = UIImage(data: responseData.data!)
            })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventViewController.onClickItemCollection(sender:)))
        cell.addGestureRecognizer(tap)
        cell.isUserInteractionEnabled = true

        
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
    
    @objc func handleAddEvent() {
        let next = AddEventViewController.newInstance(event: nil)
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func onClickItemCollection(sender: UITapGestureRecognizer){
        
        if let cell = sender.view, let indexPath = self.collectionView.indexPath(for: cell as! UICollectionViewCell) {
            let next = AddEventViewController.newInstance(event: self.events[indexPath.row])
            self.navigationController?.pushViewController(next, animated: true)
        }
    }

}

