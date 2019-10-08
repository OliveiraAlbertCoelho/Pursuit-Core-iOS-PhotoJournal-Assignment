//
//  SettingsVC.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/7/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    var selectedScroll = Int()
    var darkModeInt = Int()
    weak var delegate: PhotoDelegate?
    weak var darkDelegate: darkProtocol?
    @IBOutlet weak var scrollOut: UISegmentedControl!
    @IBOutlet weak var OrientationLabel: UILabel!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var darkModeOut: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        darkModeOut.selectedSegmentIndex = darkModeInt
        scrollOut.selectedSegmentIndex = selectedScroll
        changeBackGround()
    }
    func darkMode(){
        view.backgroundColor = .black
        darkModeLabel.textColor = .white
        OrientationLabel.textColor = .white
    }
    func lightMode(){
        view.backgroundColor = .white
        darkModeLabel.textColor = .black
        OrientationLabel.textColor = .black
    }
    @IBAction func darkModeSegment(_ sender: UISegmentedControl) {
        darkDelegate?.passDarkModeData(tag: sender.selectedSegmentIndex)
        darkModeInt = sender.selectedSegmentIndex
        changeBackGround()
    }
    func changeBackGround(){
        if darkModeInt == 0{
            lightMode()
        }else {
          darkMode()
        }
    }
    @IBAction func scrollButton(_ sender: UISegmentedControl) {
        delegate?.passData(tag: sender.selectedSegmentIndex)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

