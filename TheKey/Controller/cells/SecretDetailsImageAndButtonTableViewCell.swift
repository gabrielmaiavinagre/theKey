//
//  SecretInformationTableViewCell.swift
//  TheKey
//
//  Created by Gabriel Vinagre on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretDetailsImageAndButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameImage: UIImageView!
    @IBOutlet weak var siteURLButton: UIButton!
    
    @IBAction func copyToClipboard(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(secret: Secret, type: SecretCellsTypes) {
        
        switch type {
        case .username:
            self.usernameImage.image = #imageLiteral(resourceName: "usernameIcon")
            self.siteURLButton.setTitle(secret.getUsernamer(), for: .normal)
            
        case .siteName:
            self.usernameImage.image = #imageLiteral(resourceName: "urlIcon")
            self.siteURLButton.setTitle(secret.getSiteName(), for: .normal)
        default:
            print("error")
        }
        
    }

}
