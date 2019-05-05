//
//  DeliveryItemsView.swift
//  SwiftDelivery
//
//  Created by Nagarro on 26/04/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import UIKit

class DeliveryItemsView: LoaderBaseView {
    // MARK: Constants
    static let cellIdentifier = "itemCell"
    static let accessibilityIdentifier = "table--delivertItemTableView"
    static let estimatedHightConstant: CGFloat = 80
    static let messageLblHightConstant: CGFloat = 200
    
    // MARK: Variables
    var tableView: UITableView!
    var noResultMessageLabel: UILabel!
    
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
        self.backgroundColor = .white
        self.tableView = UITableView.init()
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        let footer = UIView()
        self.tableView.tableFooterView = footer
        self.tableView.register(DeliveryItemCell.self, forCellReuseIdentifier: DeliveryItemsViewController.cellIdentifier)
        self.tableView.estimatedRowHeight = DeliveryItemsView.estimatedHightConstant
        self.tableView.accessibilityIdentifier = accessibilityIdentifier
        
        //Message lable if no result found
        self.noResultMessageLabel = UILabel.init()
        self.noResultMessageLabel.font = Theme.CustomFont.arialHebrewBold(20)
        self.noResultMessageLabel.textColor = UIColor.lightGray
        self.noResultMessageLabel.text = LocalizationConstant.noResultFound
        self.noResultMessageLabel.textAlignment = .center
        self.noResultMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noResultMessageLabel.numberOfLines = 0
        self.noResultMessageLabel.isHidden = true
        self.addSubview(self.noResultMessageLabel)
    }
    
    private func setUpConstraints() {
        self.tableView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        self.noResultMessageLabel.widthAnchor.constraint(equalToConstant: DeliveryItemsView.messageLblHightConstant).isActive = true
        self.noResultMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.noResultMessageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
