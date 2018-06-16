//
//  SecretsTableViewController.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

     @IBOutlet weak var tableView: UITableView!
    
    private var secrets = [Secret]()
    private var viewControllerTitle = "Segredos"
    private var userInfo: UserInfo!
    private var indexOfASecretThatWillBeDeleted: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        configurationNavBar()
        hasTouchIdRegistered()
        viewControllerConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    //Configure viewcontroller
    private func viewControllerConfigurations() {

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = UIColor.appPinkColor
        self.navBarWithAddNewSecretButton()
        self.title = viewControllerTitle
        tableView.tableFooterView = UIView()
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secrets.count == 0 ? 1 : secrets.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if secrets.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "secretCellId") as! SecretTableViewCell
            cell.configureCell(secret: secrets[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "noSecretCellId") as! NoSecretsTableViewCell
        return cell
    }
 

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.goToSecretDetailsScreen(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteCustomButton = UITableViewRowAction(style: .default, title: "APAGAR", handler: {
            
            action, indexPath in
            
            self.indexOfASecretThatWillBeDeleted = indexPath.row
            self.presentAlert(type: .delete, customTitle: nil, customMessage: nil, customButton1Title: nil, customButton2Title: nil)
            
        })
        
        deleteCustomButton.backgroundColor = UIColor.appPinkColor
        
        return [deleteCustomButton]

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
//        if (editingStyle == UITableViewCellEditingStyle.delete) {
////             self.indexOfASecretThatWillBeDeleted = indexPath.row
////            self.presentAlert(type: .delete, customTitle: nil, customMessage: nil, customButton1Title: nil, customButton2Title: nil)
//
//        }
    }
    
    private func goToSecretDetailsScreen(index: Int) {
        
        guard let secret = self.secrets[index] as? Secret else {
            print("segredo estava vazio para index ", index)
        }
        
        let storyBoard = UIStoryboard(name: "SecretDetailsViewController", bundle: nil)
        let secretInfoVC = storyBoard.instantiateInitialViewController() as! SecretDetailsViewController
        secretInfoVC.passInformation(secret: secret)
        self.navigationController?.pushViewController(secretInfoVC, animated: true)
    }
    
    override func createNewSecret() {
        let storyBoard = UIStoryboard(name: "NewSecretViewController", bundle: nil)
        let newSecretVC = storyBoard.instantiateInitialViewController() as! NewSecretViewController
        self.navigationController?.pushViewController(newSecretVC, animated: true)
    }
    
    
    func receiveInfo(userInfo: UserInfo) {
        self.userInfo = userInfo
    }
    
    func reloadData() {
        self.secrets = DataManager.getAllData(username: userInfo.getUsername())
        self.tableView.reloadData()
    }
    
    override func succeedToAuth() {
        AuthenticationManager.setTouchId(userInfo: userInfo)
    }
    
    override func failedToAuth() {
        self.prepareTouchID()
    }
    
    override func alertFirstButtonAction() {
        
        guard let index = indexOfASecretThatWillBeDeleted, let sct = secrets[index] as? Secret  else {
            print("segredo não foi encontrado")
            return
        }
        
        DataManager.deleteSecret(username: userInfo.getUsername(), secret: sct)
        self.reloadData()
        
    }
    
    override func alertSecondButtonAction() {
        indexOfASecretThatWillBeDeleted = nil
    }
    

}
