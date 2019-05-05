//
//  Utility.swift
//  SwiftDelivery
//
//  Created by "" on 21/04/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift

func saveImageAtPath(imagePath: String, image: UIImage) {
    // get the documents directory url
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // choose a name for your image
    let fileName = imagePath
    // create the destination file url to save your image
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    // get your UIImage jpeg data representation and check if the destination file url already exists
    if let data = image.jpegData(compressionQuality: 1.0),
        !FileManager.default.fileExists(atPath: fileURL.path) {
        do {
            // writes the image data to disk
            try data.write(to: fileURL)
            print("file saved")
        } catch {
            print("error saving file:", error)
        }
    }
}

func imageAtFilePath(imagePath: String) -> UIImage? {
    // get the documents directory url
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    // choose a name for your image
    let fileName = imagePath
    // create the destination file url to save your image
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        if let image = UIImage(contentsOfFile: fileURL.path) {
            return image
        }
        return nil
    } else {
        return nil
    }
}

// MARK: NotificationBanner
func showBannerWith(title: String?, subtitle: String?, style: BannerStyle) {
    let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
    banner.show()
}
