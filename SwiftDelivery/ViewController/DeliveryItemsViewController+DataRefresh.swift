//
//  DeliveryItemsViewController+DataRefresh.swift
//  SwiftDelivery
//
//  Created by Nagarro on 04/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import Foundation
import UIKit

extension DeliveryItemsViewController {
    // MARK: Pagination and PullToRefresh
    func addPullToRefresh() {
        deliveryItemsView.tableView.addPullToRefreshHandler {
            DispatchQueue.main.async {
                self.performTaskAfterPullToRefresh()
            }
        }
    }
    
    func addInfiniteScrolling() {
        deliveryItemsView.tableView.addInfiniteScrollingWithHandler {
            DispatchQueue.main.async {
                self.performTaskAfterInfiniteScrolling()
            }
        }
    }
    
    func stopAnimatingPullToRefresh() {
        deliveryItemsView.tableView.pullToRefreshView?.stopAnimating()
    }
    
    func stopAnimatingInfiniteScrolling() {
        deliveryItemsView.tableView.infiniteScrollingView?.stopAnimating()
    }
    
    func performTaskAfterInfiniteScrolling() {
        self.deliveryViewModel.loadDataFromServer(shouldShowLoading: false, shouldReset: false)
    }
    
    func performTaskAfterPullToRefresh() {
        self.deliveryViewModel.loadDataFromServer(shouldShowLoading: false, shouldReset: true)
    }
    
    func setActivityIndicatiorColor() {
        self.deliveryItemsView.tableView.infiniteScrollingView?
            .setActivityIndicatorColor(Theme.CustomColor.appThemeColor)
        self.deliveryItemsView.tableView.pullToRefreshView?
            .setActivityIndicatorColor(Theme.CustomColor.appThemeColor)
    }
}
