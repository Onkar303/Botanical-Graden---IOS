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
    
    @IBOutlet weak var exibitionNameLabel: UILabel!
    @IBOutlet weak var exibitionPlantCountLabel: UILabel!
    @IBOutlet weak var exibitionCreationDate: UILabel!
    @IBOutlet weak var exibitionImageView: UIImageView!
    
    
    override func awakeFromNib() {
        
    }
    
}
