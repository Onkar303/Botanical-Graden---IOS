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
        
//        self.layer.borderWidth = 2
//        self.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }

    
}


extension UIButton {
    
    func chnageToCustomButton(){
        self.layer.cornerRadius = self.bounds.width/2
        self.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1
        
    }
    
}


