//
//  DeliveryDetailViewModel.swift
//  SwiftDelivery
//
//  Created by "" on 17/04/19.
//  Copyright © 2019 "". All rights reserved.
//

import Foundation

class DeliveryDetailViewModel: NSObject {
    // MARK: Variables
    @objc dynamic var deliveryItem: DeliveryItem! 
    
    // MARK: init
    init (model: DeliveryItem) {
        self.deliveryItem = model
    }
}
