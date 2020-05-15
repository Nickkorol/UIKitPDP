//
//  ExamplesCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol ExamplesCoordinator {
    var main: UIViewController? { get }
    func run()    
    func showCustomLayer()
    func showKeyboard()
    func showClosingSwipe()
}
