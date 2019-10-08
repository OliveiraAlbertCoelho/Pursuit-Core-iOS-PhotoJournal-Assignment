//
//  Protocol.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/4/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

protocol ButtonFunction: AnyObject{
       func showActionSheet(tag: Int)
}
protocol PhotoDelegate: AnyObject{
    func passData(tag: Int)
 
}
protocol darkProtocol: AnyObject {
    func passDarkModeData(tag: Int)
}


