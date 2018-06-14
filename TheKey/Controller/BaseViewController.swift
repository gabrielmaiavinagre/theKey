//
//  BaseViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @objc func saveSecret() {
        
    }
    
    @objc func createNewSecret() {
        
    }

}
