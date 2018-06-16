//
//  NewSecretViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class NewSecretViewController: BaseViewController {

    //Outlets
    @IBOutlet weak var siteNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var secret: Secret?
    private weak var delegate: PassInformationBetweenViewControllersProtocol!
    private var viewControllerTitle = "Novo Segredo"
    private var isAEdittedSecret = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        viewControllerConfigurations()
        if let sct = self.secret {
            fillInformationsOnTextFields(secret: sct)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let sct = self.secret {
            fillInformationsOnTextFields(secret: sct)
        }
    }
    
    private func viewControllerConfigurations() {
        self.title = viewControllerTitle
        self.navBarWithSaveButton()
    }
    
    //pass information between viewcontrollers
    public func passInformation(secret: Secret, viewControllerTitle: String?, delegate: PassInformationBetweenViewControllersProtocol) {
        self.secret = secret
        self.delegate = delegate
        isAEdittedSecret = true
        if let title = viewControllerTitle {
            self.viewControllerTitle = title
        }
    }
    
    override func saveSecret() {
        if let auth =  AuthenticationManager.getTouchId(), let siteName = self.siteNameTextField.text, let username = self.usernameTextField.text ,let password = self.passwordTextField.text, siteName != "" && username != "" && password != "" {
            
            let newSecret = Secret(name: siteName, username: username, password: password)
            if isAEdittedSecret, let sct = self.secret {
                DataManager.editSecret(username: auth.getUsername(), oldSecret: sct, secretEdited: newSecret)
                delegate.passInformation(newSecret)
            }
            else {
                DataManager.saveData(username: auth.getUsername(), secret: newSecret)
            }
            
            self.presentAlert(type: .saved, customTitle: nil, customMessage: nil, customButton1Title: nil, customButton2Title: nil)
            return
        }
        self.presentAlert(type: .cannotSave, customTitle: nil, customMessage: nil, customButton1Title: nil, customButton2Title: nil)
        print("Preencha os campos")
        print("Para salvar você deve preencher todos os campos")
        
    }
    
    func fillInformationsOnTextFields(secret: Secret) {
        self.usernameTextField.text = secret.getUsernamer()
        self.passwordTextField.text = secret.getPassword()
        self.siteNameTextField.text = secret.getSiteName()
    }
    
    override func alertFirstButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func alertSecondButtonAction() {
        
    }

}
