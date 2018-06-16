//
//  DataManager.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 14/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import KeychainSwift

class DataManager {
    
    private static var allSecrets = [Secret]()
    
    class func saveData(username: String, secret: Secret) {
        
        if allSecrets.count == 0 {
           allSecrets = getAllData(username: username)
        }
        
        if findSecret(secret: secret) == nil {
        allSecrets.append(secret)
        let data = transformToData(secret: allSecrets)
        let keychain = KeychainSwift()
        keychain.set(data, forKey: username)
        }
    }
    
    class func deleteSecret(username: String, secret: Secret) {
        
        if allSecrets.count == 0 {
             allSecrets = getAllData(username: username)
        }
        
        allSecrets = allSecrets.filter { $0 != secret }
        let data = transformToData(secret: allSecrets)
        let keychain = KeychainSwift()
        keychain.set(data, forKey: username)

    }
    
    class func saveSecrets(username: String, secrets: [Secret]) {
        let keychain = KeychainSwift()
        let data = transformToData(secret: allSecrets)
        keychain.set(data, forKey: username)
    }
    
    class func editSecret(username: String, oldSecret: Secret, secretEdited: Secret) {
        
        var secrets = [Secret]()
        
        for element in allSecrets {
        
            if element != oldSecret {
                secrets.append(element)
            }
            else {
                secrets.append(secretEdited)
            }
        }
        allSecrets = secrets
        saveSecrets(username: username, secrets: allSecrets)
       
    }
    
    class func transformToData(secret: [Secret])-> Data {
        let data = NSKeyedArchiver.archivedData(withRootObject: allSecrets)
        return data
    }

    class func transformToObject(data: Data) -> [Secret] {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Secret] ?? [Secret]()
    }
    
    class func findSecret(secret: Secret)-> Secret? {
        
        for element in allSecrets {
            
            if element == secret {
                return secret
            }
        }
        return nil
    }

    
    class func getAllData(username: String)-> [Secret] {
        
        let keychain = KeychainSwift()
        if let arrayOfData = keychain.getData(username) as? Data {
            let arrayConverted: [Secret] = transformToObject(data: arrayOfData)
            allSecrets = arrayConverted
        return arrayConverted
        }
       return [Secret]()
    }
    
}
