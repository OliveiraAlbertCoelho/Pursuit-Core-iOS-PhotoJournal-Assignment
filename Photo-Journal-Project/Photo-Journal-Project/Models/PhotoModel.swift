//
//  PhotoModel.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let name: String
    let id: Int
    let date: Date
    let image: Data
}
