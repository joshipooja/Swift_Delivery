//
//  CoreDataManager+Extension.swift
//  SwiftDelivery
//
//  Created by  "" on 16/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func saveDeliveryItem(deliveryItem: DeliveryItem) {
        guard let id = deliveryItem.id else {
            return 
        }
        let context = CoreDataManager.privateContext()
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItemsCoreDataObject.self), in: context)
        var itemObject = self.fetchItemWithId(internalIdentifier: id, from: context)
        if itemObject == nil {
            itemObject = NSManagedObject.init(entity: entityDescription!, insertInto: context) as? DeliveryItemsCoreDataObject
        }
        itemObject?.id = Int32(id)
        itemObject?.itemDescription = deliveryItem.itemDescription
        itemObject?.imagePath = deliveryItem.imageUrl
        if let location =  deliveryItem.location, let locationObj = self.saveLocationObject(location: location, context: context) {
            itemObject?.location = locationObj
        }
        if let error = CoreDataManager.sharedManager().saveMyContext(context) {
            debugPrint(error.localizedDescription)
        }
    }
    
    func fetchItemWithId(internalIdentifier: Int, from context: NSManagedObjectContext) -> DeliveryItemsCoreDataObject? {
        var fetchedObjects: [DeliveryItemsCoreDataObject]?
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        let predicate: NSPredicate = NSPredicate(format: "id == \(internalIdentifier)")
        fetch.predicate = predicate
        fetch.returnsObjectsAsFaults = false
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItemsCoreDataObject.self), in: context)
        fetch.entity = entityDescription
        do {
            fetchedObjects = try context.fetch(fetch) as? [DeliveryItemsCoreDataObject]
            if let objects = fetchedObjects, objects.count > 0 {
                return objects.first
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func saveLocationObject(location: Location, context: NSManagedObjectContext) -> LocationCoreDataObject? {
        let context = context
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: LocationCoreDataObject.self), in: context)
        if let locatonObject = NSManagedObject.init(entity: entityDescription!, insertInto: context) as? LocationCoreDataObject {
            locatonObject.lat = location.lat ?? 0.0
            locatonObject.long = location.lng ?? 0.0
            locatonObject.address = location.address
            return locatonObject
        }
        return nil
    }
    
    func allItems() -> [DeliveryItemsCoreDataObject] {
        let context = CoreDataManager.viewContext()
        var fetchedObjects: [DeliveryItemsCoreDataObject]?
        let fetch = NSFetchRequest<NSFetchRequestResult>.init()
        fetch.returnsObjectsAsFaults = false
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: DeliveryItemsCoreDataObject.self), in: context)
        fetch.entity = entityDescription
        do {
            fetchedObjects = try context.fetch(fetch) as? [DeliveryItemsCoreDataObject]
            return fetchedObjects ?? [DeliveryItemsCoreDataObject]()
        } catch {
            return [DeliveryItemsCoreDataObject]()
        }
    }
    
    func deleteAllItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: DeliveryItemsCoreDataObject.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try CoreDataManager.sharedManager().persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: CoreDataManager.privateContext())
        } catch {
            debugPrint("There is an error in deleting records")
        }
    }
}
