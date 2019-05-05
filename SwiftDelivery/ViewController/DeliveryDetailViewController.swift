//
//  DeliveryDetailViewController.swift
//  SwiftDelivery
//
//  Created by   on 15/04/19.
//  Copyright © 2019  . All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    // MARK: Constant
    static let anotationIdentifier = "Annotation"
    
    // MARK: Variables
    var deliveryDetailViewModel: DeliveryDetailViewModel?
    var deliveryDetailView: DeliveryDetailView!
    var observers = [NSKeyValueObservation?]()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  LocalizationConstant.detailNavigationTitle
        self.setUpUI()
        self.setUpConstraints()
        self.updateUI()
        self.observeViewModel()
    }
    
    private func observeViewModel() {
        self.observers = [
            deliveryDetailViewModel?.observe(\DeliveryDetailViewModel.deliveryItem, options: [.old, .new]) { [weak self] (_, _) in
                self?.updateUI()
            }]
    }
    
    // MARK: UI Configuration
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.deliveryDetailView = DeliveryDetailView.init()
        self.view.addSubview(self.deliveryDetailView)
        self.deliveryDetailView.mapView.delegate = self
    }
    
    private func setUpConstraints() {
        if #available(iOS 11, *) {
            self.deliveryDetailView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        } else {
            self.deliveryDetailView.anchor(top: self.topLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.topLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    private func updateUI() {
        self.showImageAndDescription(deliveryItem: self.deliveryDetailViewModel?.deliveryItem)
        if let lat = self.deliveryDetailViewModel?.deliveryItem.location?.lat, let long = self.deliveryDetailViewModel?.deliveryItem.location?.lng {
            self.showAnnotatiOnMapView(lat: lat, long: long, address: self.deliveryDetailViewModel?.deliveryItem.location?.address)
        }
    }
    
    func showAnnotatiOnMapView(lat: Double, long: Double, address: String?) {
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.deliveryDetailView.mapView.setRegion(region, animated: true)
        let pinLocation = MKPointAnnotation()
        if let theAddress = address {
            pinLocation.title = theAddress
        }
        pinLocation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.deliveryDetailView.mapView.addAnnotation(pinLocation)
    }
    
    private func showImageAndDescription(deliveryItem: DeliveryItem!) {
        self.deliveryDetailView.deliveryDescriptionView.data = deliveryItem
    }
    
    deinit {
        for observer in observers {
            observer?.invalidate()
        }
    }
}

// MARK: MapViewDelegate
extension DeliveryDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: DeliveryDetailViewController.anotationIdentifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: DeliveryDetailViewController.anotationIdentifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
