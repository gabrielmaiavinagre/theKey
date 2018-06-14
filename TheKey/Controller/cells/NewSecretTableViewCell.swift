//
//  NewSecretTableViewCell.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

enum SecretCellsTypes {
    
    case siteName
    case username
    case password
    
}

class NewSecretTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(type: SecretCellsTypes, fillTextField: String?) {
        
        switch type {
        case .username:
            self.cellImageView.image = #imageLiteral(resourceName: "usernameIcon")
            self.cellTextField.placeholder = "Digite o username"
            
        case .password:
            self.cellImageView.image = #imageLiteral(resourceName: "passwordIcon")
//            self.cellTextField.isSecureTextEntry = true
            self.cellTextField.placeholder = "Digite a senha"
        
        case .siteName:
            self.cellImageView.image = #imageLiteral(resourceName: "urlIcon")
            self.cellTextField.placeholder = "Digite o link do site"
        }
        
        if let text = fillTextField {
            self.cellTextField.text = text
        }

    }
    
}
