//
//  UIView+Extension.swift
//  SwiftDelivery
//
//  Created by  "" on 10/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
    // MARK: Add activityIndicator on View
    func addCenterConstraint(to indicatior: UIActivityIndicatorView) {
        
        indicatior.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatior)
        
        let widthConstraint = NSLayoutConstraint(item: indicatior, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        indicatior.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: indicatior, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20)
        indicatior.addConstraint(heightConstraint)
        
        let centerXConstraint = NSLayoutConstraint(item: indicatior, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        
        let centerYConstraint = NSLayoutConstraint(item: indicatior, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        
        self.addConstraint(centerXConstraint)
        self.addConstraint(centerYConstraint)
    }
}
