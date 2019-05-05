//
//  APIServiceRequestMangerTests.swift
//  SwiftDeliveryUITests
//
//  Created by  "" on 16/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import XCTest
@testable import SwiftDelivery

class APIServiceRequestMangerTests: XCTestCase {
    
    var deliveryItemsViewModel = DeliveryItemsViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDelivery() {
        testDeliveriesForURL(host: "mock-api-mobile.dev.lalamove.com", fileName: "Delivery.json")
    }
    
    func testDeliveriesForURL(host: String, fileName: String) {
        XCHttpStub.request(withPathRegex: host, withResponseFile: fileName)
        let responseExpectation = expectation(description: "return expected data of List")
        APIServiceRequestManager().callDeliveryItemService(offset: 0, limit: 20) { response in
            switch response {
            case .success(let items):
                XCTAssertNotNil(items, "list: expected result achived")
                XCTAssertEqual(20, items.count)
                responseExpectation.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error, "error: Expectation fulfilled with error")
            }
        }
        waitForExpectations(timeout: 50) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from list webservice")
            }
        }
    }
    
    func testDeliveryForInvalidDataFormat() {
        testDeliveriesForInvalidData(host: "mock-api-mobile.dev.lalamove.com", fileName: "InvalidDelivery.json")
    }
    
    func testDeliveriesForInvalidData(host: String, fileName: String) {
        XCHttpStub.request(withPathRegex: host, withResponseFile: fileName)
        let responseExpectation = expectation(description: "Data not in correct format")
        APIServiceRequestManager().callDeliveryItemService(offset: 0, limit: 20) { response in
            switch response {
            case .success( let item):
                XCTAssertNil(item, "error: item should be nil")
            case .failure(let error):
                XCTAssertNotNil(error, "error: Expectation fulfilled with error")
                responseExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 50) { error in
            if let error = error {
                XCTAssertNotNil(error, "Failed to get response from list webservice")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
