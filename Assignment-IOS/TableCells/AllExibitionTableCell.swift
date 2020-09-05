//
//  AllExibitionTableCell.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class AllExibitionTableCell:UITableViewCell{
    
    static let cellIdentifier = "AllExibitionTableCell"
    
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantDescriptionLabel: UILabel!
    @IBOutlet weak var planeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        
    }
    
}
