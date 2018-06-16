//
//  BaseViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import LocalAuthentication

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func configurationNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.appPinkColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.appGoldenColor]
        self.navigationController?.navigationBar.tintColor = UIColor.appGoldenColor
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    func navBarWithAddNewSecretButton() {
        let newSecretButton = UIBarButtonItem(image: #imageLiteral(resourceName: "addButton"), style: .plain, target: self, action: #selector(createNewSecret))
        
        self.navigationItem.rightBarButtonItem = newSecretButton
    }
    
    func navBarWithSaveButton() {
        let saveButton = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveSecret))
        
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveSecret() {
        
    }
    
    @objc func createNewSecret() {
        
    }
    
    func touchIdAuthorized() {
        
    }
    
    
    func prepareTouchID(isLoginVc: Bool, userInfo: UserInfo) {
        let context = LAContext()
        var error: NSError?
        
        // 2
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 3
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(succes, error) in
                    // 4
                    if succes {
                        self.showAlertController("Touch ID Authentication Succeeded")
                        if isLoginVc {
                            self.touchIdAuthorized()
                        }
                        else {
                            AuthenticationManager.setTouchId(userInfo: userInfo)
                        }
                    }
                    else {
                        self.showAlertController("Touch ID Authentication Failed")
                        if !isLoginVc {
                            self.prepareTouchID(isLoginVc: false, userInfo: userInfo)
                        }
                    }
            } )
        }
            // 5
        else {
            showAlertController("Touch ID not available")
        }
    }
    
    func showAlertController(_ message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }


}


    


