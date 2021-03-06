//
//  KeyboardViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 20.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class KeyboardViewModelImpl: KeyboardViewModel {
    var coordinator: KeyboardCoordinator!
    weak var view: KeyboardViewInput?
}
