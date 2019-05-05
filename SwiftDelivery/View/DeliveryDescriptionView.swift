//
//  DeliveryDescriptionView.swift
//  SwiftDelivery
//
//  Created by "" on 17/04/19.
//  Copyright © 2019 "". All rights reserved.
//

import UIKit

class DeliveryDescriptionView: UIView {
    // MARK: Constants
    static let imageViewHeight: CGFloat = 70
    static let descriptionLblMinHeightConstant: CGFloat = 70
    
    // MARK: Variables
    var data: DeliveryItem? {
        didSet {
            self.loadImage()
            self.loadDescription()
        }
    }
    
    var itemImageView: UIImageView!
    var itemDescriptionLabel: UILabel!
    
    // MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setUpUI()
        self.setUpConstraints()
    }
    
    // MARK: UIConfiguration
    private func setUpUI() {
        self.itemImageView = UIImageView.init(image: #imageLiteral(resourceName: "defaultIcon"))
        self.itemImageView.contentMode = .scaleAspectFill
        self.itemImageView.layer.cornerRadius = DeliveryDescriptionView.imageViewHeight/2
        self.itemImageView.clipsToBounds = true
        self.itemImageView.backgroundColor = UIColor.gray
        self.addSubview(self.itemImageView)
        
        self.itemDescriptionLabel = UILabel()
        self.itemDescriptionLabel.textColor = .black
        self.itemDescriptionLabel.font = Theme.CustomFont.arialHebrewRegular(16)
        self.itemDescriptionLabel.textAlignment = .left
        self.itemDescriptionLabel.numberOfLines = 0
        self.itemDescriptionLabel.text = ""
        self.addSubview(self.itemDescriptionLabel)
    }
    
    private func setUpConstraints() {
        self.itemImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: DeliveryDescriptionView.imageViewHeight, height: DeliveryDescriptionView.imageViewHeight)
        self.itemDescriptionLabel.anchor(top: self.itemImageView.topAnchor, left: self.itemImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
        self.itemDescriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: DeliveryDescriptionView.descriptionLblMinHeightConstant).isActive = true
    }
    
    //show description on label
    private func loadDescription() {
        self.itemDescriptionLabel.text = self.data?.itemDescription
    }
    
    //show image if available in document directory else fetch from url and save it
    private func loadImage() {
        self.itemImageView.image = #imageLiteral(resourceName: "defaultIcon")
        if  let imageUrlString = self.data?.imageUrl, let url = URL(string: imageUrlString) {
            let lastPathComponent = url.lastPathComponent
            if  let image = imageAtFilePath(imagePath: lastPathComponent) {
                self.itemImageView.image = image
            } else {
                self.itemImageView.sd_setImageFrom(url: url, placeholderImage: #imageLiteral(resourceName: "defaultIcon")) { (image, error, url) in
                    if let theImage = image {
                        saveImageAtPath(imagePath: lastPathComponent, image: theImage)
                    }
                }
            }
        } else {
            self.itemImageView.image = #imageLiteral(resourceName: "defaultIcon")
        }
    }
}
