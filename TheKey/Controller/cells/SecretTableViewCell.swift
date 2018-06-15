//
//  SecretTableViewCell.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 13/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit
import Kingfisher

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
        
        if let modifier = RequestManager.getImageRequestModifier() {
        
        if let url = URL(string: secret.getSiteHost()) {
//            self.siteImage.image?.kf.
            
            //setImage(with: url, placeholder: nil, options: [.requestModifier(modifier)])
        }
        }
        self.siteNameLabel.text = secret.getSiteName()
        self.siteUsernameLabel.text = secret.getUsernamer()
        
    }

}
