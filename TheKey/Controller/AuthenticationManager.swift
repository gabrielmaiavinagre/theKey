//
//  AuthenticationManager.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 15/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import KeychainSwift

class AuthenticationManager {
    
    class func getTouchId()-> UserInfo? {
        
        let keychain = KeychainSwift()
        
        if let userLoginData = keychain.getData("touchId") as? Data {
            return transformToObject(data: userLoginData)
        }
        return nil
    }
    
    class func setTouchId(userInfo: UserInfo) {
        
        let keychain = KeychainSwift()
        let data = transformToData(userInfo: userInfo)
        keychain.set(data, forKey: "touchId")
        
    }
    
    class func transformToData(userInfo: UserInfo)-> Data {
        let data = NSKeyedArchiver.archivedData(withRootObject: userInfo)
//        let data = NSKeyedArchiver.archivedData(withRootObject: <#T##Any#>)
        return data
    }
    
    class func transformToObject(data: Data) -> UserInfo? {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UserInfo
    }
    
    
}
