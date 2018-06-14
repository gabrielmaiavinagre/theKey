//
//  SecretInformationPasswordTableViewCell.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretDetailsPasswordTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var passwordTitleButton: UIButton!
    
    
    private var secret: Secret!
    private var isPasswordVisible =  false
    
    //IBActions
    @IBAction func showAndHidePassword(_ sender: UIButton) {
        if !isPasswordVisible {
            self.passwordTitleButton.setTitle(secret.getPassword(), for: .normal)
            isPasswordVisible = true
        }
        else {
            self.passwordTitleButton.setTitle(String(repeating: "*", count: secret.getPassword().count), for: .normal)
            isPasswordVisible = false
        }
        
    }
    @IBAction func copyToClipboardAction(_ sender: UIButton) {
        UIPasteboard.general.string = self.secret.getPassword()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(secret: Secret) {
        self.secret = secret
        self.passwordImage.image = #imageLiteral(resourceName: "passwordIcon")
        self.passwordTitleButton.setTitle(String(repeating: "*", count: secret.getPassword().count), for: .normal)
        self.isPasswordVisible = false
    }

}
