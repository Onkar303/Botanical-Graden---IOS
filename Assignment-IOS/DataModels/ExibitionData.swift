//
//  File.swift
//  Assignment-IOS
//
//  Created by Techlocker on 14/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import UIKit

class ExibitionData:NSObject{
    var exibitionName:String?
    var exibitionDescription:String?
    var latitiude:Double?
    var longitude:Double?
    var exibitionImage:Data?
    var exibitionCreationDate:Date?
    var exibitionPlants:[PlantDescription]?
    
    override init() {}
    
    init(exibitionName:String,exibitionDescription:String,latitude:Double,longitude:Double,exibitionImage:Data?,exibitionCreationDate:Date?,exibitionPlants:[PlantDescription]) {
        
        self.exibitionName = exibitionName
        self.exibitionDescription = exibitionDescription
        self.latitiude = latitude
        self.longitude = longitude
        self.exibitionImage = exibitionImage
        self.exibitionCreationDate = exibitionCreationDate
        self.exibitionPlants = exibitionPlants
        
        
    }
    
    
    
}
