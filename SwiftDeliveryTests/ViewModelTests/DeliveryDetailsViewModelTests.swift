//
//  DeliveryDetailsViewModelTests.swift
//  SwiftDeliveryTests
//
//  Created by Nagarro on 03/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import XCTest
@testable import SwiftDelivery

class DeliveryDetailsViewModelTests: XCTestCase {
    var deliveryDetailModel: DeliveryDetailViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let deliveryItem = dummyDeliveryItem()
        deliveryDetailModel = DeliveryDetailViewModel.init(model: deliveryItem)
    }
    
    private func dummyDeliveryItem() -> DeliveryItem {
        let deliveryItem = DeliveryItem()
        deliveryItem.id = 0
        deliveryItem.itemDescription = "This is dummy description"
        deliveryItem.imageUrl = "This is dummy image path"
        let location = Location()
        location.lat = 28.23
        location.lng = 78.00
        location.address = "This is dummy address"
        deliveryItem.location = location
        return deliveryItem
    }
    
    func testSetDeliveryItem() {
        let dummy = dummyDeliveryItem()
        deliveryDetailModel.deliveryItem = dummy
        XCTAssertEqual(deliveryDetailModel.deliveryItem.id, dummy.id)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliveryDetailModel = nil
        //mockDeliveryDetailViewController = nil
    }
}
