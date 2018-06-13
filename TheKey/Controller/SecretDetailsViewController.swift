//
//  SecretInformationViewController.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    public var secret: Secret!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerConfigurations()
        // Do any additional setup after loading the view.
    }

    func viewControllerConfigurations() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let usernameCell = tableView.dequeueReusableCell(withIdentifier: "imageAndButtonCellId") as! SecretDetailsImageAndButtonTableViewCell
            usernameCell.configureCell(secret: self.secret)
            return usernameCell
        
        case 1:
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

}
