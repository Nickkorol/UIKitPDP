//
//  VerificationCollectionViewCell.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 05.06.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class VerificationCollectionViewCell: UICollectionViewCell {
    
    var index = 0
    
    lazy var inputImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(inputImageView)
        inputImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(inputImageView)
        inputImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            inputImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func configure(index: Int, pinCode: String) {
        self.index = index
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        if index < pinCode.count {
            inputImageView.image = UIImage(named: "pincode_not_entered_number")
        } else {
            inputImageView.image = UIImage(named: "pincode_entered_number")
        }
    }
}
