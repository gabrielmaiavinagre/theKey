//
//  ResponseModel.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 14/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case error(String)
    case internalGenericError(String)
}

class ResponseModel {
    
    private var token: String
    
    init?(jsonReceived: Any) throws {
        
        guard let json = jsonReceived as? [String: Any], let status = json["type"] as? String else {
            throw SerializationError.error("generic error")
        }
        
        if let message = json["message"] as? String {
            throw SerializationError.error(message)
        }
        
        guard let token = json["token"] as? String, status == "sucess" else {
            throw SerializationError.error("generic error")
        }
        
        self.token = token
    }
    
    func getToken() -> String {
        return self.token
    }
    
}
