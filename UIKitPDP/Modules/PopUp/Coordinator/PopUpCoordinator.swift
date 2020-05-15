//
//  PopUpCoordinator.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 10.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

protocol PopUpCoordinator {
    var main: UIViewController? { get }
    func run()
    func dismissPopUp()
}
