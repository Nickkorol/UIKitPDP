//
//  ClosingSwipeCoordinatorImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ClosingSwipeCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension ClosingSwipeCoordinatorImpl: ClosingSwipeCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {
        root.present(mainViewController, animated: true)
    }
}
