//
//  UserInfo.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 11/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import Foundation

class Secret: NSObject, NSCoding {
    
    private var name: String = ""
    private var username: String = ""
    private var password: String = ""
    
    init(name: String, username: String, password: String) {
        
        self.name = name
        self.username = username
        self.password = password
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.username = aDecoder.decodeObject(forKey: "username") as! String
        self.password = aDecoder.decodeObject(forKey: "password") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
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
    
    func getSiteHost()-> String {
        
        if let url = URL(string: self.getSiteName()) {
            return url.host ?? ""
        }
        return ""
    }
}
