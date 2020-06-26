//
//  MyView.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 26.06.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

class MyView: UIView {
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
}
