//
//  ViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 10/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding


class CreateNewAccountViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var avoidingView: UIView!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //normal variables
    private var userInfo: UserInfo!
    private var loginButtonOpacity = LoginButtonState.disabled.rawValue
    private var viewControllerTitle = "Sair"
    
    @IBAction func loginInAction(_ sender: UIButton) {
        
        guard let confirmPasswordText = self.confirmPasswordTextField.text else {
            print("text field de confirmacao de sneha está vazio")
            return
        }
        
        if isPasswordFillingTheBasicsRequisits(password: self.userInfo.getPassword(), confirmPassword: confirmPasswordText) {
            print("send to api")
        }
    }
    
    @IBAction func backToLoginScreenAction(_ sender: UIButton) {
        
        
        self.navigationController!.popViewController(animated: true)
//        let storyBoard = UIStoryboard(name: "SecretsViewController", bundle: nil)
//        if let secretVC = storyBoard.instantiateInitialViewController() {
//            self.navigationController?.pushViewController(secretVC, animated: true)
//        }
    }
    
    //Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //Configure viewcontroller
    private func viewControllerConfigurations() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.statusBarStyle = .lightContent
        self.title = viewControllerTitle
        
        self.userInfo = UserInfo(username: "",name: "", password: "")
        self.incorrectPasswordLabel.isHidden = true
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.loginButton.isEnabled = false
        self.isLoginButtonEnabled(false)
        self.usernameTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.passwordTextField.isSecureTextEntry = true
        self.cancelButton.layer.borderWidth = 1
        self.cancelButton.layer.borderColor = UIColor.appPinkColor.cgColor
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = UIColor.appStatusBarColor
    }
    
    //Others functions
    private func incorrectPasswordLabelIsHidden(_ response: typesLoginErrors) {
        
        var text = ""
        
        switch response {
        case .incorrectLogin:
            text = response.rawValue
            
        case .lessThanEight:
            text = response.rawValue
            
        case .passwordNotCorrect:
            text = response.rawValue
            
        case .passwordAndConfirmPasswordAreIncorrected:
            text = response.rawValue
        }
        
        self.incorrectPasswordLabel.text = text
        self.incorrectPasswordLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        if usernameTextField == textField {
            confirmPasswordTextField.becomeFirstResponder()
        }
        else if confirmPasswordTextField == textField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    @objc func verifyPassword(sender: UITextField) {
        
        guard let username = self.usernameTextField.text, let password = self.passwordTextField.text, let confirmPassword = self.confirmPasswordTextField.text else {
            return
        }
        
        if username != "" && password.count > 0 && password.count >= 8 && confirmPassword.count >= 8 {
            
            self.userInfo = UserInfo(username: username, name: "", password: password)
            self.loginButton.isEnabled = true
            isLoginButtonEnabled(true)
        }
        else {
            self.loginButton.isEnabled = false
            isLoginButtonEnabled(false)
        }
    }
    
    func isPasswordFillingTheBasicsRequisits(password: String, confirmPassword: String) -> Bool {
        
        if password.count < 8 {
            print("senha com menos de  8 caracteres")
            incorrectPasswordLabelIsHidden(.lessThanEight)
            resetScreen()
            return false
        }
        else if !password.isValidPassword() {
            incorrectPasswordLabelIsHidden(.passwordNotCorrect)
            resetScreen()
            print("senha invalida")
            return false
        }
        else if password != confirmPassword {
            incorrectPasswordLabelIsHidden(.passwordAndConfirmPasswordAreIncorrected)
            resetScreen()
            return false
        }
        
        print("está correta")
        return true
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
        self.confirmPasswordTextField.text = ""
        //        self.userInfo.changeUsername("")
        self.userInfo.changePassword("")
        isLoginButtonEnabled(false)
        
    }
    
}


