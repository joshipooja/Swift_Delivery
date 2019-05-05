//
//  CoreDataManager.swift
//  SwiftDelivery
//
//  Created by  "" on 14/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func allItems() -> [DeliveryItemsCoreDataObject]
    func saveDeliveryItem(deliveryItem: DeliveryItem)
    func deleteAllItems()
}

class CoreDataManager: CoreDataManagerProtocol {
    static let  sharedCoreDataManager = CoreDataManager()
    class func sharedManager() -> CoreDataManager {
        return sharedCoreDataManager
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SwiftDelivery")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                debugPrint(error.localizedDescription)
            }
        })
        return container
    }()
    
    class func privateContext() -> NSManagedObjectContext {
        return CoreDataManager.sharedManager().persistentContainer.newBackgroundContext()
    }
    
    class func viewContext() -> NSManagedObjectContext {
        let context = CoreDataManager.sharedManager().persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    // MARK: - Core Data Saving support
    func saveMyContext(_ context: NSManagedObjectContext) -> NSError? {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                return nserror
            }
        }
        return nil
    }
}
