//
//  DeliveryItems.swift
//  SwiftDelivery
//
//  Created by  "" on 12/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import Foundation

class DeliveryItem: NSObject, Codable {
    var id: Int?
    var itemDescription: String?
    var imageUrl: String?
    var location: Location?
}

extension DeliveryItem {
    enum CodingKeys: String, CodingKey {
        case id
        case itemDescription = "description"
        case imageUrl
        case location
    }
}
