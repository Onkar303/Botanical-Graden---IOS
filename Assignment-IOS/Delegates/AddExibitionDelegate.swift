//
//  AddExibitionDelegate.swift
//  Assignment-IOS
//
//  Created by Techlocker on 16/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol AddExibitionDelegate:AnyObject {
    func addExibitionPin(exibitionAnnotation:MKAnnotation)
}
