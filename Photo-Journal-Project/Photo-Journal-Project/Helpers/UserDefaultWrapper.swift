//
//  UserDefaultWrapper.swift
//  Photo-Journal-Project
//
//  Created by albert coelho oliveira on 10/7/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

class UserDefaultWrapper {
    static let manager = UserDefaultWrapper()
    
    func store(mode: Int) {
        UserDefaults.standard.set(mode, forKey: modeKey)
    }
    func getMode() -> Int? {
        return UserDefaults.standard.value(forKey: modeKey) as? Int
    }
    private init() {}
    private let modeKey = "mode"
}
