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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar()
        hasTouchIdRegistered()
        viewControllerConfigurations()
        secrets.append(Secret(name: "www.teste123.com.br", username: "gabriel123", password: "teste123"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    //Configure viewcontroller
    private func viewControllerConfigurations() {

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navBarWithAddNewSecretButton()
        self.title = viewControllerTitle
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secrets.count
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
    
    func hasTouchIdRegistered() {
        guard let _ = AuthenticationManager.getTouchId() else {
            prepareTouchID(isLoginVc: false, userInfo: userInfo)
            return
        }
    }
    
    func receiveInfo(userInfo: UserInfo) {
        self.userInfo = userInfo
    }

}
