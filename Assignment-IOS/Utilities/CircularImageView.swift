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
        self.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
}


