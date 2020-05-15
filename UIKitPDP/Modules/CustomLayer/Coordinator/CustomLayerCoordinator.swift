//
//  CustomLayerCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol CustomLayerCoordinator {
    var main: UIViewController? { get }
    func run()
}
