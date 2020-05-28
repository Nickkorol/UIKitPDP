//
//  ButtonsAnimationCoordinatorImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 27.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ButtonsAnimationCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension ButtonsAnimationCoordinatorImpl: ButtonsAnimationCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {
        root.present(mainViewController, animated: true)
    }
}
