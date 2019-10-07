//
//  SettingsVC.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/7/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    var scrollDirection = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    weak var delegate:
       PhotoDelegate?
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        
    }
    

    @IBAction func scrollButton(_ sender: UISegmentedControl) {
        if sender.isMomentary  {
             scrollDirection = "vertical"
        } else {
            scrollDirection = "horizontal"
        }
           delegate?.passData(tag: scrollDirection)
    }
    
    
    
//    @IBAction func orientationSwitch(_ sender: UISwitch) {
//        if sender.isOn {
//            scrollDirection = "vertical"
//        }else {
//            scrollDirection = "horizontal"
//        }
//        delegate?.passData(tag: scrollDirection)
//    }
    
    @IBOutlet weak var OrientationLabel: UILabel!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
protocol PhotoDelegate: AnyObject{
    func passData(tag: String)
}
