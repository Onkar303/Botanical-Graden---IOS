//
//  AddPlantToExibition.swift
//  Assignment-IOS
//
//  Created by Techlocker on 6/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation

// MARK:- Conforming to only Classes
protocol AddPlantDelegate:AnyObject{
    func addPlantForSelection(data:PlantDescription)
}
