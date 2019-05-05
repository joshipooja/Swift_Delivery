//
//  DeliveryDetailView.swift
//  SwiftDelivery
//
//  Created by Nagarro on 26/04/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailView: UIView {
    // MARK: Variables
    var mapView: MKMapView!
    var scrollView: UIScrollView!
    var deliveryDescriptionView: DeliveryDescriptionView!
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
        self.setUpConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: UIConfiguration
    private func setUpUI() {
        self.scrollView = UIScrollView.init()
        self.addSubview(self.scrollView)
        self.mapView = MKMapView.init()
        self.deliveryDescriptionView = DeliveryDescriptionView.init()
        self.scrollView.addSubview(self.mapView)
        self.scrollView.addSubview(self.deliveryDescriptionView)
    }
    
    private func setUpConstraints() {
        self.scrollView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.mapView.anchor(top: self.scrollView.topAnchor, left: nil, bottom: nil, right: self.scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        self.mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        self.mapView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
        
        self.deliveryDescriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.deliveryDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        self.deliveryDescriptionView.topAnchor.constraint(equalTo: self.mapView.bottomAnchor).isActive = true
        self.deliveryDescriptionView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.deliveryDescriptionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
