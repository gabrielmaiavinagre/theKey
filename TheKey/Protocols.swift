//
//  Protocols.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 16/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

protocol PassInformationBetweenViewControllersProtocol: NSObjectProtocol {
    func passInformation(_ secret: Secret)
}

protocol AlertButtonsActionsProtocol {
    func alertFirstButtonAction()
    func alertSecondButtonAction()
}
