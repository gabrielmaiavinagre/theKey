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
        
        if let url = URL(string: URLs.getImage + secret.getSiteHost()) {
            
            let modifier = AnyModifier { request in
                var r = request
                r.setValue(RequestManager.getToken(), forHTTPHeaderField: "authorization")
                return r
            }
            
            self.siteImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "noImage"), options: [.requestModifier(modifier)], progressBlock: nil, completionHandler: {
                (image, error, cacheType, imageUrl) in
                
                if let img = image {
                    self.siteImage.image = img
                }
                
            })
        }
        
        self.siteNameLabel.text = secret.getSiteName()
        self.siteUsernameLabel.text = secret.getUsernamer()
        self.siteImage.roundImage()
        
    }

}
