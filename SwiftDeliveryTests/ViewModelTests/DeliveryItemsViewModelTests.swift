//
//  DeliveryItemsViewModelTests.swift
//  SwiftDeliveryTests
//
//  Created by Nagarro on 02/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import XCTest
@testable import SwiftDelivery

class DeliveryItemsViewModelTests: XCTestCase {
    var deliveryItemViewModel: DeliveryItemsViewModel?
    var mockCoreDataManager: MockCoreDataManager!
    var mockAPIRequestManager: MockAPIRequestManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        deliveryItemViewModel = DeliveryItemsViewModel()
        
        mockCoreDataManager = MockCoreDataManager()
        deliveryItemViewModel?.coreDataManager = mockCoreDataManager
        
        mockAPIRequestManager = MockAPIRequestManager()
        deliveryItemViewModel?.apiRequestManager = mockAPIRequestManager
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        mockCoreDataManager = nil
        mockAPIRequestManager = nil
    }
    
    func testloadLocalDataWithError() {
        mockCoreDataManager.isError = true
        deliveryItemViewModel?.loadDataIfAvailableInLocalStore()
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 0)
    }
    
    func testloadDataWithSuccess() {
        deliveryItemViewModel?.loadDataIfAvailableInLocalStore()
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 1)
    }
    
    func testLoadDataWithServer() {
        deliveryItemViewModel?.loadDataFromServer(shouldShowLoading: true, shouldReset: false)
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 1)
    }
    
    func testFetchItemsWithSuccess() {
        deliveryItemViewModel?.deliveryItems.removeAll()
        deliveryItemViewModel?.fetchItems(shouldReset: false)
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 1)
    }
    
    func testFetchItemsWithError() {
        deliveryItemViewModel?.deliveryItems.removeAll()
        mockAPIRequestManager.isError = true
        deliveryItemViewModel?.fetchItems(shouldReset: false)
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 0)
    }
    
    func testFetchItemsWithNoMoreResult() {
        deliveryItemViewModel?.loadDataIfAvailableInLocalStore()
        let previousCount = deliveryItemViewModel?.deliveryItems.count
        mockAPIRequestManager.noMoreResults = true
        deliveryItemViewModel?.fetchItems(shouldReset: false)
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, previousCount)
    }
    
    func testModelHasAlreadyItems() {
        deliveryItemViewModel?.loadDataIfAvailableInLocalStore()
        XCTAssertEqual(deliveryItemViewModel?.hasItems(), true)
    }
    
    func testFetchItemOnPullToRefresh() {
        deliveryItemViewModel?.loadDataIfAvailableInLocalStore()
        deliveryItemViewModel?.fetchItems(shouldReset: true)
        XCTAssertEqual(deliveryItemViewModel?.deliveryItems.count, 1)
    }
    
    func testdetailModel() {
        self.addDummyDeliveryItem()
        let detailModel = deliveryItemViewModel?.getDeliveryDetailsViewModel(for: 0)
        XCTAssertNotNil(detailModel)
    }
    
    func testdetailModelForInvalidIndex() {
        self.addDummyDeliveryItem()
        let detailModel = deliveryItemViewModel?.getDeliveryDetailsViewModel(for: 1)
        XCTAssertNil(detailModel)
    }
    
    func testNextPage() {
        self.addDummyDeliveryItem()
        let nextPage = deliveryItemViewModel?.getNextPageNo()
        XCTAssertEqual(nextPage, 1)
    }
    
    private func addDummyDeliveryItem() {
        let deliveryItem = DeliveryItem()
        deliveryItem.id = 0
        deliveryItem.itemDescription = "This is test description"
        deliveryItem.imageUrl = "This is test image path"
        deliveryItemViewModel?.deliveryItems = [deliveryItem]
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class MockCoreDataManager: CoreDataManagerProtocol {
    var isError: Bool = false
    var deliveryItemCoreDataObject: DeliveryItemsCoreDataObject?
    
    func allItems() -> [DeliveryItemsCoreDataObject] {
        if isError {
            return []
        }
        let coreDataObject = DeliveryItemsCoreDataObject.init(context: CoreDataManager.viewContext())
        coreDataObject.id = 1
        coreDataObject.itemDescription = "This is dummy description"
        coreDataObject.imagePath = "This is dummy image path"
        let location = LocationCoreDataObject.init(context: CoreDataManager.viewContext())
        location.lat = 28.23
        location.long = 78.00
        location.address = "This is dummy test address"
        coreDataObject.location = location
        deliveryItemCoreDataObject = coreDataObject
        return [deliveryItemCoreDataObject ?? coreDataObject]
    }
    
    func saveDeliveryItem(deliveryItem: DeliveryItem) {
        let coreDataObject = DeliveryItemsCoreDataObject.init(context: CoreDataManager.viewContext())
        coreDataObject.id = Int32(deliveryItem.id!)
        coreDataObject.itemDescription = deliveryItem.description
        coreDataObject.imagePath = deliveryItem.imageUrl
        let location = LocationCoreDataObject.init(context: CoreDataManager.viewContext())
        location.lat = deliveryItem.location?.lat ?? 0
        location.long = deliveryItem.location?.lng ?? 0
        location.address = deliveryItem.location?.address
        coreDataObject.location = location
        deliveryItemCoreDataObject = coreDataObject
    }
    
    func deleteAllItems() {
        deliveryItemCoreDataObject = nil
    }
}

class MockAPIRequestManager: APIServiceRequestManagerProtocol {
    var isError = false
    var noMoreResults = false
    
    func callDeliveryItemService(offset: Int, limit: Int, completion: @escaping ((Result<[DeliveryItem], Error>) -> Void)) {
        if isError {
            let error = NSError(domain: "Custom Error", code: 500, userInfo: nil)
            completion(.failure(error))
            return
        } else if noMoreResults {
            let deliveryItem = [DeliveryItem]()
            completion(.success(deliveryItem))
        } else {
            let deliveryItem = DeliveryItem()
            deliveryItem.id = 0
            deliveryItem.itemDescription = "This is dummy description"
            deliveryItem.imageUrl = "This is dummy image path"
            let location = Location()
            location.lat = 28.23
            location.lng = 78.00
            location.address = "This is dummy address"
            deliveryItem.location = location
            completion(.success([deliveryItem]))
        }
    }
}
