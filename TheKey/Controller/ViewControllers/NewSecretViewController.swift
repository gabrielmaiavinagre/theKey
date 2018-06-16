//
//  NewSecretViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class NewSecretViewController: BaseViewController  {

    @IBOutlet weak var siteNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var secret: Secret?
    private var viewControllerTitle = "Novo Segredo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        viewControllerConfigurations()
    }
    
    private func viewControllerConfigurations() {
        self.title = viewControllerTitle
        self.navBarWithSaveButton()
    }
    
    //pass information between viewcontrollers
    public func passInformation(secret: Secret, viewControllerTitle: String?) {
        self.secret = secret
        
        if let title = viewControllerTitle {
            self.viewControllerTitle = title
        }
    }
    
    override func saveSecret() {
        
        if let auth =  AuthenticationManager.getTouchId(), let siteName = self.siteNameTextField.text, let username = self.usernameTextField.text ,let password = self.passwordTextField.text {
            
            let secret = Secret(name: siteName, username: username, password: password)
            
            DataManager.saveData(username: auth.getUsername(), secret: secret)}
    }
    
    func fillInformationsOnTextFields(secret: Secret) {
        self.usernameTextField.text = secret.getUsernamer()
        self.passwordTextField.text = secret.getPassword()
        self.siteNameTextField.text = secret.getSiteName()
    }

}
