//
//  ButtonsAnimationViewModelImpl.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 27.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

final class ButtonsAnimationViewModelImpl: ButtonsAnimationViewModel {
    
    var coordinator: ButtonsAnimationCoordinator!
    weak var view: ButtonsAnimationViewInput?
    
    var highScore = 0
    
    func checkHighScore(newScore: Int) {
        if newScore < highScore || highScore == 0 {
            highScore = newScore
            view?.resetHighScore(with: highScore)
        }
    }
}
