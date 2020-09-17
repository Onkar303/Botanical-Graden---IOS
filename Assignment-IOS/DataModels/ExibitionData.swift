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
}
