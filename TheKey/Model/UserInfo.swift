//
//  UserInfo.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 11/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import Foundation

class UserInfo: Codable {
    
    private var username: String
    private var password: String
    private var name: String
    
    init(username: String, name: String, password: String) {
        self.username = username
        self.password = password
        self.name = name
    }
    
    func getUsername() -> String {
        return self.username
    }
    
    func changeUsername(_ new: String) {
        self.username = new
    }
    
    func getPassword() -> String {
        return self.password
    }
    
    func changePassword(_ new: String) {
        self.username = new
    }
    
    func getName()-> String {
        return self.name
    }
    
    func changeName(_ new: String) {
        self.name = new
    }
    
    
}
