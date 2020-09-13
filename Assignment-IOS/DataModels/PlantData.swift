//
//  Plants.swift
//  Assignment-IOS
//
//  Created by Techlocker on 2/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation


class PlantData:NSObject,Decodable {
    var data:[PlantDescription]?

    enum CodingKeys:String,CodingKey {
        case data
    }
}

class PlantDescription:NSObject,Decodable{
    var id:Int?
    var commonName:String?
    var slug:String?
    var scientificName:String?
    var yearOfDescovery:Int?
    var imageURL:String?
    var genus:String?
    var plantBibliography:String?
    var plantAuthor:String?
    var plantFamily:String?
    
    
    enum Keys:String,CodingKey{
        case id
        case commonName = "common_name"
        case slug
        case scientificName = "scientific_name"
        case yearOfDescovery = "year"
        case imageURL = "image_url"
        case genus
        case plantBibliography="bibliography"
        case plantAuthor = "author"
        case plantFamily = "family"
    }
    
    required init(from decoder: Decoder) throws {
        let plantContainer = try decoder.container(keyedBy: Keys.self)
        
        id = try? plantContainer.decode(Int.self, forKey: .id)
        commonName = try? plantContainer.decode(String.self, forKey: .commonName)
        slug = try? plantContainer.decode(String.self, forKey: .slug)
        scientificName = try? plantContainer.decode(String.self, forKey: .scientificName)
        yearOfDescovery = try? plantContainer.decode(Int.self, forKey: .yearOfDescovery)
        imageURL = try? plantContainer.decode(String.self, forKey: .imageURL)
        genus = try? plantContainer.decode(String.self, forKey: .genus)
        plantBibliography = try? plantContainer.decode(String.self, forKey: .plantBibliography)
        plantAuthor = try? plantContainer.decode(String.self, forKey: .plantAuthor)
        plantFamily = try? plantContainer.decode(String.self, forKey: .plantFamily)
    }
    
    
    
}





