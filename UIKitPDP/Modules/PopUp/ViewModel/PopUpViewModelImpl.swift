//
//  PopUpViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 10.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class PopUpViewModelImpl: PopUpViewModel {
    var coordinator: PopUpCoordinator!
    weak var view: PopUpViewInput?
    
    private var output: PopUpOutput
    
    init(output: @escaping PopUpOutput) {
        self.output = output
    }
    
    func doneButtonDidPress(text: String) {
        self.output(text)
        coordinator.dismissPopUp()
    }
}
