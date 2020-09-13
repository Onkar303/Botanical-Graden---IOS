//
//  Exibition+CoreDataProperties.swift
//  Assignment-IOS
//
//  Created by Techlocker on 14/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//
//

import Foundation
import CoreData


extension Exibition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exibition> {
        return NSFetchRequest<Exibition>(entityName: "Exibition")
    }

    @NSManaged public var exibitionDescription: String?
    @NSManaged public var exibitionName: String?
    @NSManaged public var latitude: Int16
    @NSManaged public var longitude: Int16
    @NSManaged public var exibitionImage: Data?
    @NSManaged public var plant: NSSet?

}

// MARK: Generated accessors for plant
extension Exibition {

    @objc(addPlantObject:)
    @NSManaged public func addToPlant(_ value: Plants)

    @objc(removePlantObject:)
    @NSManaged public func removeFromPlant(_ value: Plants)

    @objc(addPlant:)
    @NSManaged public func addToPlant(_ values: NSSet)

    @objc(removePlant:)
    @NSManaged public func removeFromPlant(_ values: NSSet)

}
