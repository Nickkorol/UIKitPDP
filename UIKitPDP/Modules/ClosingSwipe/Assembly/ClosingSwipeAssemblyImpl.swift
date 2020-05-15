//
//  ClosingSwipeAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ClosingSwipeAssemblyImpl: ClosingSwipeAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> ClosingSwipeCoordinator {
        let storyboard = UIStoryboard(name: "ClosingSwipe", bundle: nil)
        let identifier = String(describing: ClosingSwipeViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ClosingSwipeViewController else {
            fatalError("ClosingSwipeViewController is needed")
        }
        let viewModel = ClosingSwipeViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = ClosingSwipeCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
