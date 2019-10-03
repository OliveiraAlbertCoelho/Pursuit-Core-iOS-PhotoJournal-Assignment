//
//  PhotoViewCell.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    @IBOutlet weak var photoCell: UIImageView!
    
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    
    @IBOutlet weak var buttonOut: UIButton!
    @IBAction func buttonAct(_ sender: UIButton) {
    }
}
