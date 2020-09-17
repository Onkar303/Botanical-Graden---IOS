//
//  DatabaseController.swift
//  Assignment-IOS
//
//  Created by Techlocker on 13/9/20.
//  Copyright © 2020 Onkar. All rights reserved.
//

import Foundation
import CoreData


class DatabaseController:NSObject{
    var persistentContainer:NSPersistentContainer
    var viewContext:NSManagedObjectContext
    
    var allExibitionFetchedResultsController:NSFetchedResultsController<Exibition>?
    
    //MARK:- initializing viewContext
    override init() {
        
        persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if error != nil {
                print("cannot initialize the database")
            }
        })
        viewContext = persistentContainer.viewContext
        super.init()
        
    }
    
    //MARK:- Saving into database
    func saveContext(){
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            }catch {
                print("unable to save xontext")
            }
        }
        
    }
    
    
    //MARK:- Adding Exibition
    func addExibition(data:ExibitionData){
        let exibition = NSEntityDescription.insertNewObject(forEntityName: "Exibition", into: viewContext) as! Exibition
        exibition.exibitionName = data.exibitionName
        exibition.exibitionDescription = data.exibitionDescription
        exibition.exibitionImage = data.exibitionImage
        exibition.latitude = data.latitiude!
        exibition.longitude = data.longitude!
        exibition.dateOfCreation = data.exibitionCreationDate
        addPlant(exibitiondata: data, exibition: exibition)
    }
    
    
    func addPlant(exibitiondata:ExibitionData,exibition:Exibition){
        guard let exibitionPlants = exibitiondata.exibitionPlants else {return}
        exibitionPlants.forEach({ (data) in
            let plant = NSEntityDescription.insertNewObject(forEntityName: "Plants", into: viewContext) as! Plants
            plant.plantFamily = data.plantFamily
            plant.plantName = data.commonName
            plant.plantGenus = data.genus
            plant.plantSlug = data.slug
            plant.plantImageURL = data.imageURL
            plant.plantScientificName = data.scientificName
            plant.plantYearOfDiscovery = "\(data.yearOfDescovery!)"
            exibition.addToPlant(plant)
        })
    }
    
    //MARK:- Removing Exibition
    func removeExibition(exibition:Exibition){
        viewContext.delete(exibition)
    }
    
    
    //MARK:- Fetching all exibitions
    func fetchAllExibitions() -> [Exibition]{
        if allExibitionFetchedResultsController == nil {
            let fetchRequest:NSFetchRequest<Exibition> = Exibition.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key:"exibitionName",ascending:true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            allExibitionFetchedResultsController = NSFetchedResultsController<Exibition>(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        }
        
        do{
            try allExibitionFetchedResultsController?.performFetch()
        }catch{
            print("error fetching data oin fetch all exibition")
        }
        
        var exibitions = [Exibition]()
        if allExibitionFetchedResultsController?.fetchedObjects != nil {
            exibitions = (allExibitionFetchedResultsController?.fetchedObjects)!
        }
        return exibitions
    }
    
    
    func fecthAALPlants() -> [Plants] {
        var plants = [Plants]()
        do {
           plants = try viewContext.fetch(Plants.fetchRequest())
           return plants
        }catch {
            print("unable to fetch plants")
        }
        
        return plants
    }
    
}
