//
//  User.swift
//  RealTimeChatApp
//
//  Created by 123 on 13.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation

class User {
    var name: String
    var email: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
