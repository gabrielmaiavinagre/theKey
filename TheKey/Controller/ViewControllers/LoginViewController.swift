//
//  ViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 10/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class LoginViewController: BaseViewController, UITextFieldDelegate, APIResponseStatusProtocol {
    
    //Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!    
    @IBOutlet weak var avoidingView: UIView!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!
    
    //normal variables
    private var userInfo: UserInfo!
    private var loginButtonOpacity = LoginButtonState.disabled.rawValue
    private var viewControllerTitle = "Sair"
    
    @IBAction func loginInAction(_ sender: UIButton) {
        verifyIfLoginAndPasswordAreCorrected()
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        
        let storyBoard = UIStoryboard(name: "CreateNewAccountViewController", bundle: nil)
        if let createNewAccountVC = storyBoard.instantiateInitialViewController() {
            self.navigationController?.pushViewController(createNewAccountVC, animated: true)
        }
    }
    
    @IBAction func touchIdAction(_ sender: Any) {
        
        hasTouchIdRegistered()
    }
    
    
    //Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        if let userInfo = AuthenticationManager.getTouchId()  {
            isTouchIDButtonEnabled(true)
        }
        else {
            isTouchIDButtonEnabled(false)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        incorrectPasswordLabel.isHidden = true
    }
    
    //Configure viewcontroller
    private func viewControllerConfigurations() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.statusBarStyle = .lightContent
        self.title = viewControllerTitle
        
        self.userInfo = UserInfo(username: "", name: "", password: "")
        self.incorrectPasswordLabel.isHidden = true
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.loginButton.isEnabled = false
        self.isLoginButtonEnabled(false)
        self.usernameTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(verifyPassword), for: .editingChanged)
        self.passwordTextField.isSecureTextEntry = true
        self.createAccountButton.layer.borderWidth = 1
        self.createAccountButton.layer.borderColor = UIColor.appPinkColor.cgColor
        
        guard let userInfo = AuthenticationManager.getTouchId() else {
            isTouchIDButtonEnabled(false)
            return
        }
        
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
            
            self.userInfo = UserInfo(username: username, name: "", password: password)
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
            requestLogin(userInfo: userInfo)
        }
    }
    
    func requestLogin(userInfo: UserInfo) {
        
        RequestManager.login(user: userInfo, delegate: self)
    }
    
    override func touchIdAuthorized() {
        requestLogin(userInfo: userInfo)
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
        self.passwordTextField.text = ""
        isLoginButtonEnabled(false)
    }
    
    func changeScreen() {
        
        let storyBoard = UIStoryboard(name: "SecretsViewController", bundle: nil)
        if let secretsVC = storyBoard.instantiateInitialViewController() as? SecretsViewController {
            secretsVC.receiveInfo(userInfo: self.userInfo)
            self.navigationController?.pushViewController(secretsVC, animated: true)
        }
        resetScreen()
    }
    
    func didSucceed(token: String) {
        print("token: ", token)
        changeScreen()
    }
    
    func didFailed(error: String) {
        print("error: ", error)
        self.presentAlert(type: .custom, customTitle: "Erro ao Logar", customMessage: error, customButton1Title: "Compreendo", customButton2Title: nil)
        resetScreen()
    }
    
    override func hasTouchIdRegistered() {
        
        guard let userInfo = AuthenticationManager.getTouchId() else {
            doesntHaveTouchIDRegistered()
            return
        }
        self.userInfo = userInfo
        prepareTouchID()
    }
    
    func isTouchIDButtonEnabled(_ isEnabled: Bool) {
        touchIDButton.isEnabled = isEnabled
        if isEnabled {
            touchIDButton.alpha = LoginButtonState.enabled.rawValue
        }
        else {
            touchIDButton.alpha = LoginButtonState.disabled.rawValue
        }
    }
    
    func  doesntHaveTouchIDRegistered() {
        print("Sem cadastro do touch id")
    }
    
    override func succeedToAuth() {
        
        requestLogin(userInfo: userInfo)
    }
}

