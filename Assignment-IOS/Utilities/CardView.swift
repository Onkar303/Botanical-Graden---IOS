//
//  CardView.swift
//  Assignment-IOS
//
//  Created by Techlocker on 20/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class cardView:UIView{
    
    @IBInspectable var cornerRadius:CGFloat = CGFloat(Constants.CORNER_RAIUS)
    
    @IBInspectable var shadowOffSetWidth:CGFloat = 0
    
    @IBInspectable var shadowOffSetHeight:CGFloat = 5
    
    @IBInspectable var shadowColor:UIColor = UIColor.black
    
    @IBInspectable var shadowOpacity:CGFloat = 0.5
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize.zero
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
        layer.backgroundColor = UIColor(named: "CustomColor")?.cgColor
    }
}
