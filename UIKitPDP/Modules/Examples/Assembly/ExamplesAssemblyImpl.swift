//
//  ExamplesAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ExamplesAssemblyImpl: ExamplesAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> ExamplesCoordinator {
        let storyboard = UIStoryboard(name: "Examples", bundle: nil)
        let identifier = String(describing: ExamplesViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ExamplesViewController else {
            fatalError("ExamplesViewController is needed")
        }
        let viewModel = ExamplesViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = ExamplesCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
