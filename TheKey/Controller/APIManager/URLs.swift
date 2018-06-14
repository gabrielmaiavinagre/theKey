//
//  URLs.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 14/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit


struct URLs {
    
    static var createAccount : String { get{
        return "https://dev.people.com.ai/mobile/api/v2/register"
    }
    }
    
   static  var login : String { get{
        return "https://dev.people.com.ai/mobile/api/v2/login"
        }
    }
    
    static var getImage : String { get{
        return "https://dev.people.com.ai/mobile/api/v2/logo/"
        }
    }
    
}
