//
//  ButtonsAnimationAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 27.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class ButtonsAnimationAssemblyImpl: ButtonsAnimationAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> ButtonsAnimationCoordinator {
        let storyboard = UIStoryboard(name: "ButtonsAnimation", bundle: nil)
        let identifier = String(describing: ButtonsAnimationViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? ButtonsAnimationViewController else {
            fatalError("ButtonsAnimationViewController is needed")
        }
        let viewModel = ButtonsAnimationViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = ButtonsAnimationCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
