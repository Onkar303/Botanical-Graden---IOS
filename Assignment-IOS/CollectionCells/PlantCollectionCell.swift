//
//  PlantCollectionViewCell.swift
//  Assignment-IOS
//
//  Created by Techlocker on 13/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import UIKit

class PlantCollectionCell: UICollectionViewCell {
    
    static let cellIdentifier = "plantCell"
    
    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    
    
    override func prepareForReuse() {
        plantImageView.image = nil
    }
    
}
