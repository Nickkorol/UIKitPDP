//
//  ExamplesViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class ExamplesViewModelImpl: ExamplesViewModel {
    var coordinator: ExamplesCoordinator!
    weak var view: ExamplesViewInput?
    
    let headers = ["IBDesignable collection view",
    "UIViewController closing by swipe",
    "Custom CALayer",
    "Core Animation"]
    
    func viewDidLoad() {
        view?.showHeaders(headers: headers)
    }
    
    func showExample(index: Int) {
        switch index {
        case 0:
            coordinator.showKeyboard()
        case 1:
            coordinator.showClosingSwipe()
        case 2:
            coordinator.showCustomLayer()
        case 3:
            coordinator.showButtonsAnimation()
        default:
            break
        }
    }
}
