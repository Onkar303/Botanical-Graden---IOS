//
//  Plants+CoreDataProperties.swift
//  Assignment-IOS
//
//  Created by Techlocker on 17/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//
//

import Foundation
import CoreData


extension Plants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plants> {
        return NSFetchRequest<Plants>(entityName: "Plants")
    }

    @NSManaged public var plantGenus: String?
    @NSManaged public var plantFamily: String?
    @NSManaged public var plantImageURL: String?
    @NSManaged public var plantName: String?
    @NSManaged public var plantSlug: String?
    @NSManaged public var plantScientificName: String?
    @NSManaged public var plantYearOfDiscovery: String?
    @NSManaged public var toExibition: Exibition?

}
