//
//  ViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 10/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var avoidingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       self.usernameTextField.delegate = self
//        KeyboardAvoiding.avoidingView = self.avoidingView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
//    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        KeyboardAvoiding.avoidingView = self.avoidingView
//        return true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

