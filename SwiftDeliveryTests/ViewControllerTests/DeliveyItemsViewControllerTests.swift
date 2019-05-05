//
//  DeliveyItemsViewControllerTests.swift
//  SwiftDeliveryTests
//
//  Created by  "" on 16/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import XCTest
import NotificationBannerSwift
@testable import SwiftDelivery

class DeliveyItemsViewControllerTests: XCTestCase {
    
    var deliveryItemVC: DeliveryItemsViewController = DeliveryItemsViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let navController = AppDelegate.delegate().window?.rootViewController as! UINavigationController
        deliveryItemVC = navController.viewControllers[0] as! DeliveryItemsViewController
        deliveryItemVC.viewDidLoad()
    }
    
    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryItemVC.title)
        XCTAssertNotNil(deliveryItemVC.deliveryItemsView.tableView)
        XCTAssertNotNil(deliveryItemVC.deliveryItemsView.noResultMessageLabel)
        XCTAssertNotNil(deliveryItemVC.deliveryItemsView.tableView.infiniteScrollingView)
    }
    
    func testTableViewDelegateDataSource() {
        XCTAssertTrue(deliveryItemVC.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(deliveryItemVC.conforms(to: UITableViewDataSource.self))
    }
    
    func testCellConfiguration() {
        let tableView = deliveryItemVC.deliveryItemsView.tableView
        let cell = deliveryItemVC.tableView(tableView!, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
    }
    
    func testShouldShowNoResultMessage () {
        if deliveryItemVC.deliveryViewModel.deliveryItems.count > 0 {
            XCTAssertTrue(deliveryItemVC.deliveryItemsView.noResultMessageLabel.isHidden)
        }
    }
    
    func testUpdateUI() {
        let deliveryItem = DeliveryItem()
        deliveryItemVC.deliveryViewModel.deliveryItems.append(deliveryItem)
        deliveryItemVC.updateUIOnResponse(error: nil)
        XCTAssertTrue(deliveryItemVC.deliveryItemsView.noResultMessageLabel.isHidden)
    }
    
    func testUpdateUIOnError() {
        let deliveryItem = DeliveryItem()
        deliveryItemVC.deliveryViewModel.deliveryItems.append(deliveryItem)
        let error = NSError.init(domain: "Custom error", code: 500, userInfo: nil)
        deliveryItemVC.updateUIOnResponse(error: error)
        XCTAssertTrue(deliveryItemVC.deliveryItemsView.noResultMessageLabel.isHidden)
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
