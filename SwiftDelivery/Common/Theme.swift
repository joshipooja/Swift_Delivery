//
//  Theme.swift
//  SwiftDelivery
//
//  Created by Nagarro on 04/05/19.
//  Copyright © 2019 Nagarro. All rights reserved.
//

import UIKit

struct Theme {
    
    static func setNavigationBarApperence() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = CustomColor.navigationBarTintColor
        navigationBarAppearace.barTintColor =  Theme.CustomColor.appThemeColor
        // change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.navigationBarTintColor, NSAttributedString.Key.font: CustomFont.arialHebrewBold(16)]
    }
    
    struct CustomColor {
        static let appThemeColor: UIColor = UIColor(red: 209.0 / 255.0, green: 138.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
        static let navigationBarTintColor: UIColor = .white
    }
    
    struct CustomFont {
        static func arialHebrewBold(_ size: CGFloat) -> UIFont {
            return UIFont(name: "ArialHebrew-Bold", size: size)!
        }
        
        static func arialHebrewRegular(_ size: CGFloat) -> UIFont {
            return UIFont(name: "ArialHebrew", size: size)!
        }
    }
}
