//
//  ButtonsAnimationCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 27.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol ButtonsAnimationCoordinator {
    var main: UIViewController? { get }
    func run()
}
