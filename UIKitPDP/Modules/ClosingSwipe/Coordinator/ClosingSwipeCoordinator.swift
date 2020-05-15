//
//  ClosingSwipeCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol ClosingSwipeCoordinator {
    var main: UIViewController? { get }
    func run()
    func showPopUp(output: @escaping PopUpOutput)
}
