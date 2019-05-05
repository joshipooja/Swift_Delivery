//
//  DeliveryItemsViewModel.swift
//  SwiftDelivery
//
//  Created by  "" on 10/04/19.
//  Copyright © 2019 "". All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class DeliveryItemsViewModel: NSObject {
    // MARK: Variables
    @objc dynamic var deliveryItems = [DeliveryItem]()
    @objc dynamic var error: Error?
    @objc dynamic var shouldShowLoader = false
    
    var isLoading = false
    private var itemsPerPage = 20
    
    var coreDataManager: CoreDataManagerProtocol = CoreDataManager.sharedManager()
    var apiRequestManager: APIServiceRequestManagerProtocol = APIServiceRequestManager()
    
    // MARK: Loaddata
    func loadData() {
        self.loadDataIfAvailableInLocalStore()
        if self.deliveryItems.count == 0 {
            self.loadDataFromServer(shouldShowLoading: true, shouldReset: false)
        }
    }
    
    // MARK: Loaddata from localStorage
    //load data from local store
    func loadDataIfAvailableInLocalStore() {
        let allItems = coreDataManager.allItems()
        let convertedObjects = self.convertAllObject(coreDataObjects: allItems)
        self.populateDataSource(items: convertedObjects)
    }
    
    //Convert all coreDataObject to modelObject
    private func convertAllObject(coreDataObjects: [DeliveryItemsCoreDataObject]) -> [DeliveryItem] {
        var items = [DeliveryItem]()
        for item in coreDataObjects {
            let modelObject = self.convertModelObject(from: item)
            items.append(modelObject)
        }
        return items
    }
    
    //Populate deliveryitems model
    private func populateDataSource (items: [DeliveryItem]) {
        self.deliveryItems = items
    }
    
    private func saveToDatabase (items: [DeliveryItem] ) {
        for aItem in items {
            coreDataManager.saveDeliveryItem(deliveryItem: aItem)
        }
    }
    
    //Remove all items
    private func resetData() {
        self.deliveryItems.removeAll()
        coreDataManager.deleteAllItems()
    }
    
    // MARK: Loaddata from server
    func loadDataFromServer(shouldShowLoading: Bool, shouldReset: Bool) {
        self.shouldShowLoader = shouldShowLoading
        self.fetchItems(shouldReset: shouldReset)
    }
    
    // Get next index and setup data
    func fetchItems(shouldReset: Bool) {
        //return if already request in process
        if self.isLoading {
            return
        }
        self.isLoading = true
        // calculate next page start index based on total items
        var nextPageNumber = self.getNextPageNo()
        //if need to reset page no will start from 0 again
        if shouldReset {
            nextPageNumber = 0
        }
        apiRequestManager.callDeliveryItemService(offset: nextPageNumber, limit: self.itemsPerPage) {[weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let items):
                if !items.isEmpty {
                    if shouldReset {
                        self?.resetData()
                    }
                    self?.deliveryItems.append(contentsOf: items)
                    self?.saveToDatabase(items: items)
                } else if self?.hasItems() == true {
                    //if no more items left
                    showBannerWith(title: nil, subtitle: LocalizationConstant.noMoreResult, style: .warning)
                }
            case .failure(let error):
                self?.error = error
                return
            }
            self?.error = nil
        }
    }
    
    func getNextPageNo() -> Int {
        let currentPageNumber = self.deliveryItems.count - 1
        let nextPageNumber = currentPageNumber +  1
        return nextPageNumber
    }
    
    func hasItems() -> Bool {
        return self.deliveryItems.count > 0
    }
    
    // MARK: get detailViewModel
    func getDeliveryDetailsViewModel(for index: Int) -> DeliveryDetailViewModel? {
        if self.deliveryItems.count > index {
            return DeliveryDetailViewModel.init(model: self.deliveryItems[index] )
        }
        return nil
    }
    
    // MARK: ConvertCoreDataModelObject
    func convertModelObject(from coreDataObject: DeliveryItemsCoreDataObject) -> DeliveryItem {
        let tempModel = DeliveryItem()
        tempModel.id = Int(coreDataObject.id)
        if let description = coreDataObject.itemDescription {
            tempModel.itemDescription = description
        }
        if let imagePath = coreDataObject.imagePath {
            tempModel.imageUrl = imagePath
        }
        if let theLocation = coreDataObject.location {
            let location = Location()
            location.address = theLocation.address
            location.lat = theLocation.lat
            location.lng = theLocation.long
            tempModel.location = location
        }
        return tempModel
    }
    
}
