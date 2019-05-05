//
//  DeliveryItemsViewController
//  SwiftDelivery
//
//  Created by   on 10/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import UIKit
import NotificationBannerSwift

class DeliveryItemsViewController: UIViewController {
    // MARK: Variables
    static let cellIdentifier = "itemCell"
    var deliveryItemsView: DeliveryItemsView!
    let deliveryViewModel = DeliveryItemsViewModel()
    var observers = [NSKeyValueObservation]()
    
    // MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.setUpConstraints()
        self.deliveryViewModel.loadData()
    }
    
    // MARK: UI Configuration
    private func setUpUI() {
        self.title = LocalizationConstant.navigationTitle
        self.view.backgroundColor = .white
        self.deliveryItemsView = DeliveryItemsView.init()
        self.view.addSubview(self.deliveryItemsView)
        
        self.addInfiniteScrolling()
        self.addPullToRefresh()
        self.setActivityIndicatiorColor()
        
        self.deliveryItemsView.tableView.delegate = self
        self.deliveryItemsView.tableView.dataSource = self
        
        self.observeViewModel()
    }
    
    private func setUpConstraints() {
        if #available(iOS 11, *) {
            self.deliveryItemsView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        } else {
            self.deliveryItemsView.anchor(top: self.topLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.bottomLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
    }
    
    private func observeViewModel() {
        self.observers = [
            deliveryViewModel.observe(\DeliveryItemsViewModel.deliveryItems, options: [.old, .new]) { [weak self] (_, _) in
                self?.reloadData()
            }, deliveryViewModel.observe(\DeliveryItemsViewModel.error, options: [.old, .new]) { [weak self] (_, changedValue) in
                self?.updateUIOnResponse(error: changedValue.newValue as? Error)
            }, deliveryViewModel.observe(\DeliveryItemsViewModel.shouldShowLoader, options: [.old, .new]) { [weak self] (_, newValue) in
                if let shouldShowLoader = newValue.newValue, shouldShowLoader {
                    self?.showLoader()
                }
            }
        ]
    }
    
    private func showHideNoResultMessage() {
        self.deliveryItemsView.noResultMessageLabel.isHidden = self.deliveryViewModel.deliveryItems.count > 0
    }
    
    func updateUIOnResponse(error: Error?) {
        if let theError = error {
            showBannerWith(title: nil, subtitle: theError.localizedDescription, style: .danger)
        }
        self.stopLoadingAnimation()
        self.showHideNoResultMessage()
    }
    
    private func stopLoadingAnimation() {
        self.deliveryItemsView.hideLoader()
        self.stopAnimatingInfiniteScrolling()
        self.stopAnimatingPullToRefresh()
    }
    
    private func showLoader() {
        self.deliveryItemsView.showLoader(mainTitle: LocalizationConstant.loading, subTitle: nil)
    }
    
    private func reloadData() {
        self.deliveryItemsView.tableView.reloadData()
    }
    
    // MARK: Navigation
    func pushToDeliveryDetailViewController(deliveryDetailViewModel: DeliveryDetailViewModel) {
        let controller = DeliveryDetailViewController()
        controller.deliveryDetailViewModel = deliveryDetailViewModel
        navigationController?.pushViewController(controller, animated: true)
    }
    
    deinit {
        for observer in observers {
            observer.invalidate()
        }
    }
}

// MARK: UITableViewDelegate/DataSource
extension DeliveryItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryItemsViewController.cellIdentifier, for: indexPath) as! DeliveryItemCell
        cell.accessoryType = .disclosureIndicator
        tableView.separatorColor = Theme.CustomColor.appThemeColor
        tableView.separatorInset = UIEdgeInsets.zero
        if self.deliveryViewModel.deliveryItems.count > indexPath.row {
            cell.deliveryItem = self.deliveryViewModel.deliveryItems[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryViewModel.deliveryItems.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let deliverydetailViewModel = self.deliveryViewModel.getDeliveryDetailsViewModel(for: indexPath.row) {
            self.pushToDeliveryDetailViewController(deliveryDetailViewModel: deliverydetailViewModel)
        }
    }
}
