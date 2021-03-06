//
//  SecretInformationViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,  PassInformationBetweenViewControllersProtocol {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var viewControllerTitle = "Segredo"
    private var secret: Secret!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        viewControllerConfigurations()
        navBarWithEditButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func viewControllerConfigurations() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = viewControllerTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let usernameCell = tableView.dequeueReusableCell(withIdentifier: "imageAndButtonCellId") as! SecretDetailsImageAndButtonTableViewCell
            usernameCell.configureCell(secret: self.secret, type: .siteName)
            return usernameCell
            
        case 1:
            let usernameCell = tableView.dequeueReusableCell(withIdentifier: "imageAndButtonCellId") as! SecretDetailsImageAndButtonTableViewCell
            usernameCell.configureCell(secret: self.secret, type: .username)
            return usernameCell
            
        case 2:
            let passwordCell = tableView.dequeueReusableCell(withIdentifier: "passwordCellId") as! SecretDetailsPasswordTableViewCell
            passwordCell.configureCell(secret: self.secret)
            return passwordCell
            
        default:
            return UITableViewCell()
        }
    }
    
    //pass information between viewcontrollers
    public func passInformation(secret: Secret) {
        self.secret = secret
        
    }
    
    override func editSecret() {
        let storyBoard = UIStoryboard(name: "NewSecretViewController", bundle: nil)
        let newSecretVC = storyBoard.instantiateInitialViewController() as! NewSecretViewController
        newSecretVC.passInformation(secret: self.secret, viewControllerTitle: "Editar Segredo", delegate: self)
        self.navigationController?.pushViewController(newSecretVC, animated: true)
    }
    
    func passInformation(_ secret: Secret) {
        self.secret = secret
    }
}
