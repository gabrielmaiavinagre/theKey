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
    case passwordAndConfirmPasswordAreIncorrected = "senha e confirmação da senha estão diferentes"
    
}

enum LoginButtonState: CGFloat {
    
    case enabled = 1
    case disabled = 0.7
}

class LoginViewController: BaseViewController, UITextFieldDelegate, APIResponseStatusProtocol {

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
    private var viewControllerTitle = "Sair"
    
    @IBAction func loginInAction(_ sender: UIButton) {
        verifyIfLoginAndPasswordAreCorrected()
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        
//       var secretsss = DataManager.getAllData(username: "gabrielUser")
        
//        var secret = Secret(name: "segredo1", username: "user1", password: "senha1")
//        var secret2 = Secret(name: "segredo2", username: "user2", password: "senha2")
//        DataManager.saveData(username: "gabrielUser", secret: secret)
//        DataManager.saveData(username: "gabrielUser", secret: secret2)
//
//        secretsss = DataManager.getAllData(username: "gabrielUser")
//        DataManager.deleteSecret(username: "gabrielUser", secret: secret)
//        secretsss = DataManager.getAllData(username: "gabrielUser")
        
        
        
//        RequestManager.createAccount(user: userInfo, delegate: self)
        
//        let parameters = [
//            "email":"GABRI79@email.com",
//            "name":"Igor Silva",
//            "password":"Senha@12346"
//        
//        ]
        
//        RequestManager.makeGenericRequest(url: "https://dev.people.com.ai/mobile/api/v2/register", parameters: parameters)
//       let storyBoard = UIStoryboard(name: "CreateNewAccountViewController", bundle: nil)
//        if let createNewAccountVC = storyBoard.instantiateInitialViewController() {
//        self.navigationController?.pushViewController(createNewAccountVC, animated: true)
//        }
    }
    
    @IBAction func touchIdAction(_ sender: Any) {
        
        if let auth = AuthenticationManager.getTouchId() {
            prepareTouchID()
            userInfo = auth
        }
        print("Sem registro de touch id")
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
//        self.usernameTextField.text = ""
        self.passwordTextField.text = ""
//        self.userInfo.changeUsername("")
        self.userInfo.changePassword("")
        isLoginButtonEnabled(false)
        
    }
    
    
    func didSucceed(token: String) {
        print("token: ", token)
    }
    
    func didFailed(error: String) {
        print("error: ", error)
    }
    
}

