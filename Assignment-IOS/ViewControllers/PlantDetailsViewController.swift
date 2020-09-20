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
    var plantDescription:PlantDescription?
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
        
        if plantDescription == nil {
            plantScientificNameLabel.text = plant?.plantScientificName
            plantYearOfDiscoveryLabel.text = plant?.plantYearOfDiscovery
            plantFamilyLabel.text = plant?.plantFamily
            plantDescriptionLabel.text = plant?.plantGenus
            Utilities.fetchImage(imageView:plantImageView, url: plant?.plantImageURL)
            self.title = plant?.plantName
        }else {
            plantDescriptionLabel.text = plantDescription?.genus
            plantScientificNameLabel.text = plantDescription?.scientificName
            plantFamilyLabel.text = plantDescription?.plantFamily
            Utilities.fetchImage(imageView:plantImageView, url: plantDescription?.imageURL)
            self.title = plantDescription?.commonName
            guard let year = plantDescription?.yearOfDescovery else { return }
            plantYearOfDiscoveryLabel.text = "\(year)"
        }
        //plantNameLabel.text = plant?.plantName
    }

}
