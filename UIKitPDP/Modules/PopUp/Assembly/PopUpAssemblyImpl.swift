//
//  PopUpAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 10.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class PopUpAssemblyImpl: PopUpAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> PopUpCoordinator {
        let storyboard = UIStoryboard(name: "PopUp", bundle: nil)
        let identifier = String(describing: PopUpViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? PopUpViewController else {
            fatalError("PopUpViewController is needed")
        }
        let viewModel = PopUpViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = PopUpCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
