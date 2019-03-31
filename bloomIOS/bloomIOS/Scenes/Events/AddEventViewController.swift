//
//  AddEventViewController.swift
//  bloomIOS
//
//  Created by Tristan Luong on 31/03/2019.
//  Copyright © 2019 Tristan Luong. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var latitudeLabel: UITextField!
    @IBOutlet weak var longitudeLabel: UITextField!
    @IBOutlet weak var promotionalCode: UITextField!
    
    
    class func newInstance() -> AddEventViewController{
        let dvc = AddEventViewController()
        return dvc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Create event"


    }


    @IBAction func createButton(_ sender: UIButton) {
        
        
        
        print("test")
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
