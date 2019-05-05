//
//  CoreDataManagerTests.swift
//  SwiftDeliveryTests
//
//  Created by  "" on 16/04/19.
//  Copyright © 2019  . All rights reserved.
//

import XCTest
@testable import SwiftDelivery
import CoreData

class CoreDataManagerTests: XCTestCase {
    
    var testCoreDataManager: CoreDataManager?
    
    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "SwiftDelivery", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
                
            }
        }
        return container
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testCoreDataManager = CoreDataManager.sharedManager()
        testCoreDataManager?.persistentContainer = mockPersistantContainer
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        testCoreDataManager = nil
    }
    
    func testCheckEmpty() {
        if let manager = self.testCoreDataManager {
            let rows = manager.allItems()
            XCTAssertEqual(rows.count, 0)
        } else {
            XCTFail("data is not empty")
        }
    }
    
    func testFetchRecords() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanger is nil")
            return
        }
        let rows = manager.allItems()
        XCTAssertEqual(rows.count, 0)
    }
    
    func testInsert() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanger is nil")
            return
        }
        let deliveryItem = self.createDummyDeliveryItem(id: 1)
        manager.saveDeliveryItem(deliveryItem: deliveryItem)
        _ =  manager.saveMyContext(mockPersistantContainer.viewContext)
        let items = manager.allItems()
        XCTAssertEqual(items.count, 1)
    }
    
    func testDataAvailableWithId() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanger is nil")
            return
        }
        let deliveryItem = createDummyDeliveryItem(id: 1)
        manager.saveDeliveryItem(deliveryItem: deliveryItem)
        _ = manager.saveMyContext(mockPersistantContainer.viewContext)
        let object = manager.fetchItemWithId(internalIdentifier: 1, from: mockPersistantContainer.viewContext)
        XCTAssertEqual(object?.id, 1)
    }
    
    func testDataAvailableWithInvalidId() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanger is nil")
            return
        }
        let deliveryItem = createDummyDeliveryItem(id: 1)
        manager.saveDeliveryItem(deliveryItem: deliveryItem)
        _ = manager.saveMyContext(mockPersistantContainer.viewContext)
        let object = manager.fetchItemWithId(internalIdentifier: 2, from: mockPersistantContainer.viewContext)
        XCTAssertNil(object)
    }
    
    func createDummyDeliveryItem(id: Int) -> DeliveryItem {
        let deliveryItem = DeliveryItem()
        deliveryItem.id = id
        deliveryItem.itemDescription = "Dummy description for test data"
        deliveryItem.imageUrl = "Dummy url for test data"
        
        let location = Location()
        location.lat = 28.2200134
        location.lng = 77.9220012
        location.address = "Dummy address for test data"
        deliveryItem.location = location
        return deliveryItem
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            guard let manager = self.testCoreDataManager else {
                XCTFail("coredatamanger is nil")
                return
            }
            _ = manager.allItems()
            // Put the code you want to measure the time of here.
        }
    }
    
}
