//
//  KeyboardAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 20.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class KeyboardAssemblyImpl: KeyboardAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> KeyboardCoordinator {
        let storyboard = UIStoryboard(name: "Keyboard", bundle: nil)
        let identifier = String(describing: KeyboardViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? KeyboardViewController else {
            fatalError("KeyboardViewController is needed")
        }
        let viewModel = KeyboardViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = KeyboardCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
