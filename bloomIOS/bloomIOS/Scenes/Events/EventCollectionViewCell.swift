//
//  EventCollectionViewCell.swift
//  bloomIOS
//
//  Created by Tristan Luong on 04/04/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

protocol EventCellDelegate: class {
    func delete(cell: EventCollectionViewCell)
}

class EventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageCollectionView: UIImageView!
    @IBOutlet var titleCollectionView: UILabel!
    
    weak var delegate: EventCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
     
    @IBAction func dropEventButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    

}
