//
//  Enums.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 16/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

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

enum TouchIdStatus {
    
    case succeed
    case failed
    case error
}

enum TypesOfAlerts {
    
    case saved
    case delete
    case registerTouchID
    case custom
    case cannotSave
}
