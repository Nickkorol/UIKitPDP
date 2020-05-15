//
//  PopUpCoordinatorImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 10.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

final class PopUpCoordinatorImpl {

    weak var root: UIViewController!
    weak var mainViewController: UIViewController!
    private let transition = PanelTransition()

    init(root: UIViewController, mainViewController: UIViewController) {
        self.root = root
        self.mainViewController = mainViewController
    }

}

extension PopUpCoordinatorImpl: PopUpCoordinator {

    var main: UIViewController? { return mainViewController }

    func run() {        
        mainViewController.transitioningDelegate = transition
        mainViewController.modalPresentationStyle = .custom
        root.present(mainViewController, animated: true)
    }
    
    func dismissPopUp() {
        mainViewController.dismiss(animated: true, completion: nil)
    }
}
