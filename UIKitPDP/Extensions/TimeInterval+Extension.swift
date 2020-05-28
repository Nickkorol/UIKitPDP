//
//  TimeInterval+Extension.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 28.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation

extension TimeInterval {
    var timeString: String {
        let minutes = Int(self / 60)
        let seconds = Int(self) - (minutes * 60)
        let result = String(format: "%02i:%02i", minutes, seconds)
        return result
    }
}
