//
//  KeyboardCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 20.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardCoordinator {
    var main: UIViewController? { get }
    func run()
}
