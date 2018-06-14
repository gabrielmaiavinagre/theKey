//
//  SecretTableViewCell.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

class SecretTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siteImage: UIImageView!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var siteUsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(secret: Secret) {
        self.siteImage.image = #imageLiteral(resourceName: "passwordIcon")
        self.siteNameLabel.text = secret.getSiteName()
        self.siteUsernameLabel.text = secret.getUsernamer()
        
    }

}
