//
//  PlantDetailsViewController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit


class PlantDetailsViewController:UIViewController{
    
    var plant:Plants?
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantScientificNameLabel: UILabel!
    @IBOutlet weak var plantYearOfDiscoveryLabel: UILabel!
    @IBOutlet weak var plantFamilyLabel: UILabel!
    @IBOutlet weak var plantDescriptionLabel: UILabel!
    @IBOutlet weak var plantImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setData(){
        plantNameLabel.text = plant?.plantName
        plantScientificNameLabel.text = plant?.plantScientificName
        plantYearOfDiscoveryLabel.text = plant?.plantYearOfDiscovery
        plantFamilyLabel.text = plant?.plantFamily
        plantImageView.setRounded()
        Utilities.fetchImage(imageView:plantImageView, url: plant?.plantImageURL)
    }

}
