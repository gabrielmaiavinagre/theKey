//
//  BaseViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import LocalAuthentication

class BaseViewController: UIViewController, AlertButtonsActionsProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func navBarWithEditButton() {
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editSecret))
        
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func saveSecret() {
        
    }
    
    @objc func createNewSecret() {
        
    }
    
    func touchIdAuthorized() {
        
    }
    
    @objc func editSecret() {
        
    }
    
    func hasTouchIdRegistered() {
        
        guard let _ = AuthenticationManager.getTouchId() else {
            prepareTouchID()
            return
        }
    }
    
    func prepareTouchID() {
        let context = LAContext()
        var error: NSError?
        
        // check if Touch ID is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "Authenticate with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:
                {(succes, error) in
                    
                    if succes {
                        DispatchQueue.main.async {
                            self.showAlertController("Touch ID Authentication Succeeded", .succeed)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.showAlertController("Touch ID Authentication Failed", .failed)
                        }
                    }
            } )
        }
        
        else {
            showAlertController("Touch ID not available", .error)
        }
    }
    
    func showAlertController(_ message: String, _ status: TouchIdStatus) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            
            void in
            
            switch status {
                
            case .succeed:
                self.succeedToAuth()
                
            case .failed:
                self.failedToAuth()
                
            case .error:
                print("not available")
            }
            
        }))
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    func failedToAuth() {
        
    }
    
    func succeedToAuth() {
        
    }
    
    func presentAlert(type: TypesOfAlerts, customTitle: String?, customMessage: String?, customButton1Title: String?, customButton2Title: String?) {
        
        var title: String = ""
        var message: String = ""
        var button1Title: String = ""
        var button2Title: String?
        
        switch type {
        case .saved:
            title = "SEGREDO SALVO :x"
            message = "Você pode editar a qualquer momento as informações."
            button1Title = "PERFEITO"
            
        case .delete:
            title = "DESEJA EXCLUIR?"
            message = "Essa ação é irreversível. Site a ser excluído: www.teste.com.br"
            button1Title = "SIM"
            button2Title = "Cancelar"
            
        case .custom:
            if let titleAlert = customTitle, let messageAlert = customMessage, let bt1Title = customButton1Title {
                
                title = titleAlert
                message = messageAlert
                button1Title = bt1Title
                
                if let bt2Title = customButton2Title {
                    button2Title = bt2Title
                }
            }
            
        case .registerTouchID:
            title = "Cadastre o touch id"
            message = "Iremos usar verificação por digital para você não precisar digitar a senha toda vez que for entrar no aplicativo."
            button1Title = "perfeito"
            
        case .cannotSave:
            title = "Não foi possível savar"
            message = "Para salvar você precisa preencher todos os campos"
            button1Title = "Perfeito"
            
        }
        
        
        let storyBoard = UIStoryboard(name: "Alert", bundle: nil)
        if let alertVC = storyBoard.instantiateInitialViewController() as? AlertViewController {
            alertVC.passAlertInfo(title: title, message: message, button1Title: button1Title, button2Title: button2Title, delegate: self)
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.modalPresentationStyle = .overCurrentContext
            self.navigationController?.present(alertVC, animated: true, completion: nil)
        }
        
    }
    
    func alertFirstButtonAction() {
    }
    
    func alertSecondButtonAction() {
    }
    
}





