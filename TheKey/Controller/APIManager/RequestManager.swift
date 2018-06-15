//
//  RequestManager.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 14/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

enum RequestStatus {
    
    case success
    case error
}


protocol APIResponseStatusProtocol {
    
    func didSucceed(token: String)
    func didFailed(error: String)
}

class RequestManager {
    
    private static var token = ""
    private static var delegate:  APIResponseStatusProtocol!
    
    class func createAccountOrLoginRequest(url: String, parameters: [String: String], responseHandler: @escaping (_ response: RequestStatus, _ token: String, _ error: String)->Void)  {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON {
            
            response in
            
            do {
                let token = try ResponseModel(jsonReceived: response.result.value)
                if let token = token?.getToken() {
                   return responseHandler(.success, token, "")
                }
                return responseHandler(.error, "",  "Erro no recebimento do Token")
                
            } catch SerializationError.error(let errorMessage) {
                return responseHandler(.error, "", errorMessage)
            } catch {
                return responseHandler(.error, "", "")
            }
        }
    }
    
    class func createAccount(user: UserInfo , delegate: APIResponseStatusProtocol) {

        self.delegate = delegate
//        let parameters = ["email": user.getUsername(),"name": user.getName(), "password": user.getPassword()]
 let parameters = ["email": "GABRI79weD@email.com","name": "nome123", "password": "Senha@12346"]
        createAccountOrLoginRequest(url: URLs.createAccount, parameters: parameters, responseHandler: {
            
            (status, token, error) in
            
            if status == .success {
                self.delegate.didSucceed(token: token)
            }
            else {
                self.delegate.didFailed(error: error)
            }
        })
    }
    
    class func login(user: UserInfo , delegate: APIResponseStatusProtocol) {
        
        self.delegate = delegate
        //        let parameters = ["email": user.getUsername(),"name": user.getName(), "password": user.getPassword()]
        let parameters = ["email": "GABRI79weD@email.com","name": "nome123", "password": "Senha@12346"]
        createAccountOrLoginRequest(url: URLs.login, parameters: parameters, responseHandler: {
            
            (status, token, error) in
            
            if status == .success {
                self.delegate.didSucceed(token: token)
            }
            else {
                self.delegate.didFailed(error: error)
            }
            
        })
    }
    
    
    class func getImageRequestModifier()-> AnyModifier? {
        
        let modifier = AnyModifier { request in
            var r = request
            r.setValue(self.token, forHTTPHeaderField: "Access-Token")
            return r
        }
        return nil
    }
    
    
    
}
