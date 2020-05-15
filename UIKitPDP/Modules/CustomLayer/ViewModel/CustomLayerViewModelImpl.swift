//
//  CustomLayerViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class CustomLayerViewModelImpl: CustomLayerViewModel {
    var coordinator: CustomLayerCoordinator!
    weak var view: CustomLayerViewInput?
}
