//
//  RequestManager.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 14/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import Alamofire

enum RequestStatus {
    
    case sucess
    case error
    
}

class RequestManager {
    
    private static var token = ""
    
    class func makeGenericRequest(url: String, parameters: [String: String], responseHandler: @escaping (_ response: RequestStatus, _ token: String, _ Error: String)->Void)  {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            
            response in
            
            if let json = response.result.value as? [String: String], let status = json["type"] as? String {
                print(json)
                    if status == "error" {
                        print("erro")
                        if let message = json["message"] {
                            return responseHandler(.error, "", message)
                        }
                        return responseHandler(.error, "", "")
                    }
                    else if status == "sucess"  {
                        if let token = json["token"] as? String {
                            self.token = token
                            return responseHandler(.sucess, token, "" )
                        }
                    }
                
            }
            else {
                 return responseHandler(.error, "", "")
            }
        }
        
    }
    
//    class func getSiteImage()-> String {
//
//    }
//
    class func createAccount(user: UserInfo , _ responseHandler: @escaping (_ response: RequestStatus, _ token: String, _ Error: String)->Void) {

        let parameters = ["email": user.getUsername(),"name": user.getName(), "password": user.getPassword()]
        
        RequestManager.makeGenericRequest(url: URLs.createAccount, parameters: parameters, responseHandler: {
            
            (requestStatus, token, error) in
            
//            responseHandler(re)
        
            
        })
        
    }
    

//
//    class func login() {
//
//    }
    
    
}
