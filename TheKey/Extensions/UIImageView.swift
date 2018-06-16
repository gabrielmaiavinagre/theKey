//
//  UIImage.swift
//  TheKey
//
//  Created by Gabriel Maia Vinagre Costa on 16/06/18.
//  Copyright © 2018 gabrielVinagre. All rights reserved.
//

import UIKit

extension UIImageView {
    func roundImage() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.frame.height/2
    self.clipsToBounds = true
    }
    
}
