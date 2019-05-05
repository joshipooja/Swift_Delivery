//
//  DeliveryDetailViewControllerTests.swift
//  SwiftDeliveryTests
//
//  Created by "" on 17/04/19.
//  Copyright © 2019 "". All rights reserved.
//

import XCTest
import MapKit
@testable import SwiftDelivery

class DeliveryDetailsViewControllerTests: XCTestCase {
    
    var deliveryDetailVC: DeliveryDetailViewController!
    
    override func setUp() {
        let deliveryItem = DeliveryItem()
        let deliveryDetailViewModel = DeliveryDetailViewModel.init(model: deliveryItem)
        deliveryDetailVC = DeliveryDetailViewController()
        deliveryDetailVC.deliveryDetailViewModel = deliveryDetailViewModel
        deliveryDetailVC.viewDidLoad()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryDetailVC.title)
        XCTAssertNotNil(deliveryDetailVC.deliveryDetailViewModel)
        XCTAssertNotNil(deliveryDetailVC.deliveryDetailViewModel?.deliveryItem)
        XCTAssertNotNil(deliveryDetailVC.deliveryDetailView.scrollView)
        XCTAssertNotNil(deliveryDetailVC.deliveryDetailView.mapView)
    }
    
    func testMapViewDelegate () {
        XCTAssertTrue(deliveryDetailVC.conforms(to: MKMapViewDelegate.self))
    }
    
    func testMapViewAnnotation() {
        let mapView = deliveryDetailVC.deliveryDetailView.mapView
        let annotationView = deliveryDetailVC.mapView(mapView!, viewFor: MKPointAnnotation())
        XCTAssertNotNil(annotationView)
    }
    
    func testAnnotationCount() {
        //let annotationView = deliveryDetailVC.mapView(mapView!, viewFor: MKPointAnnotation())
        deliveryDetailVC.showAnnotatiOnMapView(lat: 28.00, long: 78.00, address: "")
        let mapView = deliveryDetailVC.deliveryDetailView.mapView
        XCTAssertGreaterThan(mapView!.annotations.count, 0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        deliveryDetailVC = nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
