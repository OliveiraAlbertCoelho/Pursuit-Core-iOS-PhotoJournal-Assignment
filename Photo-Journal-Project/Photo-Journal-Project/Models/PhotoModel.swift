//
//  PhotoModel.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let userPost: String
    let date: String
    let image: Data
   var dateFormat: String{
       let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: self.date)
    dateFormatter.dateFormat = "MMM dd,yyyy"
    return  dateFormatter.string(from: date!)
        }
}
