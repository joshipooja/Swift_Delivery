//
//  UIImageView+Download.swift
//  SwiftDelivery
//
//  Created by  "" on 14/04/19.
//  Copyright © 2019  "". All rights reserved.
//

import UIKit
import SDWebImage

typealias ImageDownloadCompletion = ((_ image: UIImage?, _ error: Error?, _ url: URL?) -> Void)

extension UIImageView {
    
    func sd_setImageFrom(url: URL, placeholderImage: UIImage? = nil, onCompletion: ImageDownloadCompletion? = nil) {
        // Cancel all previous In-queue download
        self.sd_cancelCurrentImageLoad()
        let indicator = LoaderBaseView().getActivityIndicator()
        //Add to imageview
        addSubview(indicator)
        if indicator.constraints.count == 0 {
            addCenterConstraint(to: indicator)
        }
        if placeholderImage == nil {
            self.image = nil
            self.backgroundColor = UIColor.gray
            indicator.color = UIColor.white
        }
        indicator.startAnimating()
        let previousBackgroundColor = self.backgroundColor
        //Call image downloading method
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: [], completed: { (image, error, cache, url) in
            if placeholderImage == nil {
                self.backgroundColor = UIColor.clear
            }
            if error != nil {
                self.backgroundColor = previousBackgroundColor
            }
            indicator.stopAnimating()
            indicator.removeFromSuperview()
            onCompletion?(image, error, url)
        })
    }
}
