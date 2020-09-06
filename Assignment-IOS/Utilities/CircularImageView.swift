//
//  CircularImageView.swift
//  Assignment-IOS
//
//  Created by Techlocker on 6/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func setRounded(){
        
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}


