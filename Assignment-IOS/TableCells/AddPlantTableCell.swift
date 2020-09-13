//
//  AddPlantTableCell.swift
//  Assignment-IOS
//
//  Created by Techlocker on 5/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class AddPlantTableCell:UITableViewCell{
    
    static let cellIdentifier = "addPlantCell"
    
    @IBOutlet weak var commanNameLabel: UILabel!
    @IBOutlet weak var slugLabel: UILabel!
    @IBOutlet weak var scientificNameLabel: UILabel!
    @IBOutlet weak var yearOfDiscoveryLabel: UILabel!
    @IBOutlet weak var genusLabel: UILabel!
    @IBOutlet weak var plantFamilyLabel: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    
    override func awakeFromNib() {
        
    }
}
