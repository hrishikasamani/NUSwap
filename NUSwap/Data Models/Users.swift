//
//  Users.swift
//  NUSwap
//
//  Created by Hrishika Samani on 11/23/24.
//

import Foundation

struct User: Codable{
    var name: String
    var email: String
    var phone: String
    
    init(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
