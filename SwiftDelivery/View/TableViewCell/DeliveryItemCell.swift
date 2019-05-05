//
//  DeliveryItemCell.swift
//  SwiftDelivery
//
//  Created by  "" on 10/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import UIKit

class DeliveryItemCell: UITableViewCell {
    // MARK: Variables
    var deliveryView: DeliveryDescriptionView!
    var deliveryItem: DeliveryItem? {
        didSet {
            deliveryView?.data = deliveryItem
        }
    }
    
    // MARK: init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.deliveryView = DeliveryDescriptionView.init()
        self.addSubview(self.deliveryView)
        self.deliveryView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.deliveryView.itemDescriptionLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
