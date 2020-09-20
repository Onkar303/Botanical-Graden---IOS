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
import MapKit


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
    
    static func convertFromPlantsToPlantDescription(data:Plants) -> PlantDescription {
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
    
    public static func ADD_DEFAULT_GARDENS(databaseController:DatabaseController?){

                
                let plantDescriptionOne = PlantDescription()
                plantDescriptionOne.commonName = "coconut paspalum"
                plantDescriptionOne.genus = "Paspalum"
                plantDescriptionOne.id = 162832
                plantDescriptionOne.imageURL = "http://d2seqvvyy3b8p2.cloudfront.net/2e37294cd4b3c0ea408ed6fd9bb999de.jpg"
                plantDescriptionOne.plantAuthor = "Lam."
                plantDescriptionOne.plantBibliography = "abl. Encycl. 1: 176 (1791)"
                plantDescriptionOne.plantFamily = "Poaceae"
            plantDescriptionOne.yearOfDescovery = 1791
                plantDescriptionOne.slug = "paspalum-laxum"
                
                
                let plantDescriptionTwo = PlantDescription()
                plantDescriptionTwo.commonName = "coconut palm"
                plantDescriptionTwo.genus = "Cocos"
                plantDescriptionTwo.id = 122263
                plantDescriptionTwo.imageURL = "https://bs.floristic.org/image/o/3d907876dd89dcf4880c50fb0786191a1cb95589"
                plantDescriptionTwo.plantAuthor = "L."
                plantDescriptionTwo.plantBibliography = "Sp. Pl.: 1188 (1753)"
                plantDescriptionTwo.plantFamily = "Arecaceae"
                plantDescriptionTwo.slug = "cocos-nucifera"
            plantDescriptionTwo.yearOfDescovery = 1753
                
                let plantDescriptionThree = PlantDescription()
                plantDescriptionThree.commonName = "double coconut"
                plantDescriptionThree.genus = "Lodoicea"
                plantDescriptionThree.id = 151095
                plantDescriptionThree.imageURL = "https://bs.floristic.org/image/o/1ad4853b6c359bac439ef21a714a9b5568c91b63"
                plantDescriptionThree.plantAuthor = "L."
                plantDescriptionTwo.yearOfDescovery = 1807
                plantDescriptionThree.plantBibliography = "(J.F.Gmel.) Pers."
                plantDescriptionThree.plantFamily = "Arecaceae"
                plantDescriptionThree.slug = "lodoicea-maldivica"
                
                
                let plants = [plantDescriptionOne,plantDescriptionTwo,plantDescriptionThree]
                 
                let ExibitionData1 = ExibitionData(exibitionName: "The Orchards", exibitionDescription: "The orchards are the best that show a variety of data", latitude:-37.831843, longitude: 144.980429, exibitionImage: UIImage(named:"exibition1")?.pngData(), exibitionCreationDate: Date(), exibitionPlants: plants)
                
                databaseController?.addExibition(data: ExibitionData1)
                
        let ExibitionData2 = ExibitionData(exibitionName: "The Blooms", exibitionDescription: "Blooms show case an amamzing collection of flowers mesmerising the user", latitude: -37.830352, longitude: 144.977702, exibitionImage: UIImage(named:"exibition2")?.pngData(), exibitionCreationDate: Date(), exibitionPlants: plants)
                
                databaseController?.addExibition(data: ExibitionData2)
                
                let ExibitionData3 = ExibitionData(exibitionName: "The Sunrisers", exibitionDescription: "This exibition displays sunflowers of different genus", latitude: -37.830979, longitude:  144.983886, exibitionImage: UIImage(named:"exibition3")?.pngData(), exibitionCreationDate: Date(), exibitionPlants: plants)
                databaseController?.addExibition(data: ExibitionData3)
                
                let ExibitionData4 = ExibitionData(exibitionName: "The Platoons", exibitionDescription: "This excibition displays a varty of indigeneous species", latitude: -37.829650, longitude: 144.983414, exibitionImage: UIImage(named:"exibition4")?.pngData(), exibitionCreationDate: Date(), exibitionPlants: plants)
                databaseController?.addExibition(data: ExibitionData4)
                
                let ExibitionData5 = ExibitionData(exibitionName: "The Mixers", exibitionDescription: "This exibition displays a number of hybrid plants", latitude:-37.832972 , longitude: 144.983478, exibitionImage:UIImage(named:"exibition5")?.pngData(), exibitionCreationDate: Date(), exibitionPlants: plants)
                databaseController?.addExibition(data: ExibitionData5)
                databaseController?.saveContext()
        }
    
        
    
    
}
