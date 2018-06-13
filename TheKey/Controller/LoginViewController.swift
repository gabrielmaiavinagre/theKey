//
//  ViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 10/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

enum typesLoginErrors: String {
    
    case lessThanEight = "senha com menos de 8 caracteres"
    case passwordNotCorrect = "senha deve ter 1 número, 1 letra e 1 caractere especial"
    case incorrectLogin = "senha ou usuário incorretos"
    
}

enum LoginButtonState: CGFloat {
    
    case enabled = 1
    case disabled = 0.7
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var avoidingView: UIView!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    //normal variables
    private var userInfo: UserInfo!
    private var loginButtonOpacity = LoginButtonState.disabled.rawValue
    
    @IBAction func loginInAction(_ sender: UIButton) {
        verifyIfLoginAndPasswordAreCorrected()
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
   
       let storyBoard = UIStoryboard(name: "SecretsTableViewController", bundle: nil)
        if let secretVC = storyBoard.instantiateInitialViewController() {
        self.navigationController?.pushViewController(secretVC, animated: true)
        }
    }
    
    //Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //Configure viewcontroller
    private func viewControllerConfigurations() {
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.userInfo = UserInfo(username: "", password: "")
        self.incorrectPasswordLabel.isHidden = true
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.loginButton.isEnabled = false
        self.isLoginButtonEnabled(false)
        self.usernameTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.createAccountButton.layer.borderWidth = 1
        self.createAccountButton.layer.borderColor = UIColor.appPinkColor.cgColor
    }
    
    //Others functions
    private func incorrectPasswordLabelIsHidden(_ response: typesLoginErrors) {
        
        var text = ""
        
        switch response {
        case .incorrectLogin:
            text = typesLoginErrors.incorrectLogin.rawValue
            
        case .lessThanEight:
            text = typesLoginErrors.lessThanEight.rawValue
            
        case .passwordNotCorrect:
            text = typesLoginErrors.passwordNotCorrect.rawValue
        }
        
        self.incorrectPasswordLabel.text = text
        self.incorrectPasswordLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        if usernameTextField == textField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @objc func verifyPassword(sender: UITextField) {
        
        guard let username = self.usernameTextField.text, let password = self.passwordTextField.text else {
            return
        }
        
        if username != "" && password.count > 0 && password.count >= 8 {
            
            self.userInfo = UserInfo(username: username, password: password)
            self.loginButton.isEnabled = true
            isLoginButtonEnabled(true)
        }
        else {
            self.loginButton.isEnabled = false
            isLoginButtonEnabled(false)
        }
    }
    
    func isPasswordFillingTheBasicsRequisits(password: String) -> Bool {
        
        if password.count < 8 {
            print("senha com menos de  8 caracteres")
            incorrectPasswordLabelIsHidden(.lessThanEight)
            resetScreen()
            return false
        }
        if !password.isValidPassword() {
            incorrectPasswordLabelIsHidden(.passwordNotCorrect)
            resetScreen()
            print("senha invalida")
            return false
        }
        
        print("está correta")
        return true
    }
    
    func verifyIfLoginAndPasswordAreCorrected() {
        if isPasswordFillingTheBasicsRequisits(password: self.userInfo.getPassword()) {
            print("send to api")
        }
    }
    
    func isLoginButtonEnabled(_ state: Bool) {
        
        if state {
            self.loginButton.alpha = LoginButtonState.enabled.rawValue
            self.loginButton.isEnabled = true
        }
        else {
            self.loginButton.alpha = LoginButtonState.disabled.rawValue
            self.loginButton.isEnabled = false
        }
        
    }
    
    
    func resetScreen() {
//        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
//        self.userInfo.changeUsername("")
        self.userInfo.changePassword("")
        isLoginButtonEnabled(false)
        
    }
    
}

