//
//  focusDelegate.swift
//  Assignment-IOS
//
//  Created by Techlocker on 5/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import MapKit

protocol FocusDelegate:AnyObject{
    func focusOnLocation(annotation:MKPointAnnotation)
    
}
