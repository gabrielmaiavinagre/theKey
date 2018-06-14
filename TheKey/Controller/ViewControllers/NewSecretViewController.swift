//
//  NewSecretViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class NewSecretViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var secret: Secret?
    private var viewControllerTitle = "Novo Segredo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfigurations()
    }
    
    private func viewControllerConfigurations() {
        self.title = viewControllerTitle
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navBarWithSaveButton()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newSecretCellId") as! NewSecretTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.configureCell(type: .siteName, fillTextField: self.secret?.getSiteName())
            
        case 1:
            cell.configureCell(type: .username, fillTextField: self.secret?.getUsernamer())
            
        case 2:
            cell.configureCell(type: .password, fillTextField: self.secret?.getPassword())

        default:
            print("não caiu em nenhum dos casos de configuracao da célula de novo segredo")
        }
        
        return cell
    }
    
    //pass information between viewcontrollers
    public func passInformation(secret: Secret, viewControllerTitle: String?) {
        self.secret = secret
        
        if let title = viewControllerTitle {
            self.viewControllerTitle = title
        }
    }
    
    override func saveSecret() {
        
    }

}
