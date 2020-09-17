//
//  Utilities.swift
//  Assignment-IOS
//
//  Created by Techlocker on 23/8/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit
import Network


class Utilities{
    
    
    static func customAlertController(title:String,message:String) -> UIAlertController
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Ok", style: .default, handler: nil))
        return alertController
    }
    
    
    static func fetchImage(imageView:UIImageView,url:String?)
    {
        guard let stringUrl = url else {return}
        let url = URL(string:stringUrl)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("error fetching imgaes")
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
            }
        }.resume()
    }
    
    static func convertToPlantsFromPlantDescription(data:Plants) -> PlantDescription {
        let plantDescription = PlantDescription()
        plantDescription.commonName = data.plantName
        plantDescription.genus = data.plantGenus
        plantDescription.slug = data.plantSlug
        plantDescription.imageURL = data.plantImageURL
        plantDescription.plantFamily = data.plantFamily
        plantDescription.scientificName = data.plantScientificName
        plantDescription.yearOfDescovery = Int(data.plantYearOfDiscovery!)
        return plantDescription
        
    }
    
    static func checkForInternetConnectivity()->Bool {
        
        let monitor = NWPathMonitor()
        var isConnected = false
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                isConnected = true
            }
        }
        return isConnected
    }
    
}
