//
//  SettingsVC.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/7/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var selectedScroll = Int()
    weak var delegate:
       PhotoDelegate?
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBAction func darkModeSwitch(_ sender: UISwitch) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        scrollOut.selectedSegmentIndex = selectedScroll
    }
    
    @IBOutlet weak var scrollOut: UISegmentedControl!
    
    @IBAction func scrollButton(_ sender: UISegmentedControl) {
        delegate?.passData(tag: sender.selectedSegmentIndex)
        
        }
    
    
    

    @IBOutlet weak var OrientationLabel: UILabel!
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
protocol PhotoDelegate: AnyObject{
    func passData(tag: Int)
}
