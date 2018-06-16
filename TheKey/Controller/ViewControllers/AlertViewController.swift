//
//  AlertViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 16/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit





class AlertViewController: UIViewController {
    
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertMessageLabel: UILabel!
    
    @IBOutlet weak var alertFirstButton: UIButton!
    
    @IBOutlet weak var alertSecondButton: UIButton!
    
    private var alertTitle: String = ""
    private var message: String = ""
    private var button1Title: String = "OK"
    private var button2Title: String?
    private var isHidden = false
    private var delegate: AlertButtonsActionsProtocol!
    
    @IBAction func button1Action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate.alertFirstButtonAction()
        })
    }
    
    @IBAction func button2Action(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.delegate.alertSecondButtonAction()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configureAlertInfo()
    }
    
    //Configure viewcontroller
    private func viewControllerConfigurations() {
        self.alertSecondButton.layer.borderWidth = 1
        self.alertSecondButton.layer.borderColor = UIColor.appPinkColor.cgColor
        isSecondButtonHidden(self.isHidden)
        self.alertTitleLabel.text?.uppercased()
    }
    
    func isSecondButtonHidden(_ isHidden: Bool) {
        self.alertSecondButton.isHidden = isHidden
    }
    
    func passAlertInfo(title: String, message: String, button1Title: String, button2Title: String?, delegate: AlertButtonsActionsProtocol) {
        self.alertTitle = title
        self.message = message
        self.button1Title = button1Title
        if let bt = button2Title {
            self.button2Title = bt
        }
        else {
            isHidden = true
        }
        self.delegate = delegate
    }
    
    private func configureAlertInfo() {
        
        self.alertTitleLabel.text = alertTitle
        self.alertMessageLabel.text = message
        self.alertFirstButton.setTitle(self.button1Title.uppercased(), for: .normal)
        if let bt = button2Title {
            self.alertSecondButton.setTitle(bt.uppercased(), for: .normal)
        }
        
    }
    
}
