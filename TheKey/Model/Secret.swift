//
//  UserInfo.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 11/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import Foundation

class Secret {
    
    private var name: String
    private var username: String
    private var password: String
    
    init(name: String, username: String, password: String) {
        
        self.name = name
        self.username = username
        self.password = password
    }
    
    func getSiteName() -> String {
        return self.name
    }
    
    func changeSiteName(_ new: String) {
        self.name = new
    }
    
    func getUsernamer() -> String {
        return self.username
    }
    
    func changeUsername(_ new: String) {
        self.username = new
    }
    
    func getPassword() -> String {
        return password
    }
    
    func changePassword(_ new: String) {
        self.password = new
    }
}
