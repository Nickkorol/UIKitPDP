//
//  CustomLayerAssemblyImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class CustomLayerAssemblyImpl: CustomLayerAssembly {

    private let root: UIViewController!

    init(root: UIViewController) {
        self.root = root
    }

    func assembly() -> CustomLayerCoordinator {
        let storyboard = UIStoryboard(name: "CustomLayer", bundle: nil)
        let identifier = String(describing: CustomLayerViewController.self)
        guard let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? CustomLayerViewController else {
            fatalError("CustomLayerViewController is needed")
        }
        let viewModel = CustomLayerViewModelImpl()
        controller.viewModel = viewModel

        let coordinator = CustomLayerCoordinatorImpl(root: root, mainViewController: controller)

        viewModel.coordinator = coordinator
        viewModel.view = controller
        return coordinator
    }
}
