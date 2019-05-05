//
//  UitilityTests.swift
//  SwiftDeliveryTests
//
//  Created by Nagarro on 02/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import XCTest
@testable import SwiftDelivery

class UitilityTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownloadAndSaveImageFromUrl() {
        let itemImageView = UIImageView.init()
        let urlString = "https://xyz/image.jpeg"
        if let url = URL(string: urlString) {
            let lastPathComponent = url.lastPathComponent
            itemImageView.sd_setImageFrom(url: url, placeholderImage: #imageLiteral(resourceName: "defaultIcon")) { (image, error, url) in
                if let theImage = image {
                    XCTAssertNotNil(theImage)
                    saveImageAtPath(imagePath: lastPathComponent, image: theImage)
                }
            }
        }
    }
    
    func testSaveImageToDocumentDirectory() {
        let image = #imageLiteral(resourceName: "defaultIcon")
        let urlPath = "/testImage1.jpeg"
        removeFileAtPath(path: urlPath)
        saveImageAtPath(imagePath: urlPath, image: image)
        let imageAtPath = imageAtFilePath(imagePath: urlPath)
        XCTAssertNotNil(imageAtPath)
    }
    
    func testCheckFileAtInvalidUrl() {
        let invalidPath = "/invalidPath.jpeg"
        let imageAtPath = imageAtFilePath(imagePath: invalidPath)
        XCTAssertNil(imageAtPath)
    }
    
    private func removeFileAtPath(path: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = path
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
