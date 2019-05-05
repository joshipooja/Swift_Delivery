//
//  LoaderBaseView.swift
//  SwiftDelivery
//
//  Created by Nagarro on 05/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

let indicatorTag = -2011

// - MARK: - Loading Progress View
class LoaderBaseView: UIView {
    
    func showLoader(mainTitle title: String!, subTitle subtitle: String? = nil) {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.label.text = title
        hud.detailsLabel.text = subtitle
        hud.isSquare = true
        hud.mode = .indeterminate
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func getActivityIndicator() -> UIActivityIndicatorView {
        
        if let existingSpinner = self.viewWithTag(indicatorTag) as? UIActivityIndicatorView {
            return existingSpinner
        }
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tag = indicatorTag
        activityIndicator.color = Theme.CustomColor.appThemeColor
        return activityIndicator
    }
}
