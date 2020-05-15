//
//  ClosingSwipeViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class ClosingSwipeViewModelImpl: ClosingSwipeViewModel {
    var coordinator: ClosingSwipeCoordinator!
    weak var view: ClosingSwipeViewInput?
    
    var elements = ["0", "1"]
    
    func viewDidLoad() {
        view?.configure(elements: elements)
    }
    
    func addNote() {
        coordinator.showPopUp(output: popUpOutput)
    }
    
    func popUpOutput(text: String) {
        elements.append(text)
        view?.configure(elements: elements)
    }
}
