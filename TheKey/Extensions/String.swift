//
//  String.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 11/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import Foundation


extension String {
    
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    
}
