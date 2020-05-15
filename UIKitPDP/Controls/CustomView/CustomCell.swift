//
//  CustomCell.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 20.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit
import AudioToolbox

enum PinCodeKeyboardTitles {
    case digit(number: Int)
    case biometricAuth
    case backspace
}

protocol CustomCollectionViewCellDelegate: class {
    func addDigitToCode(digit: Int)
    func backspaceButtonPressed()
    func initiateBiometricAuth()
}

class CustomCell: UICollectionViewCell {
    @IBOutlet weak var keyboardButton: UIButton!
    
    private let biometricAuth = BiometricIDAuth()
    private var title: PinCodeKeyboardTitles?
    weak var delegate: CustomCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(index: Int, canAuthWithBiometry: Bool) {
        keyboardButton.setTitle("", for: .normal)
        keyboardButton.setImage(nil, for: .normal)
        var pinCodeKeyboardButtonTitle = PinCodeKeyboardTitles.digit(number: index+1)
        switch index {
        case 9:
            pinCodeKeyboardButtonTitle = PinCodeKeyboardTitles.biometricAuth
        case 10:
            pinCodeKeyboardButtonTitle = PinCodeKeyboardTitles.digit(number: 0)
        case 11:
            pinCodeKeyboardButtonTitle = PinCodeKeyboardTitles.backspace
        default:
            pinCodeKeyboardButtonTitle = PinCodeKeyboardTitles.digit(number: index+1)
        }
        self.title = pinCodeKeyboardButtonTitle
        switchKeyboardCellAppearance(with: pinCodeKeyboardButtonTitle, canAuthWithBiometry: canAuthWithBiometry)
    }
    
    func switchKeyboardCellAppearance(with title: PinCodeKeyboardTitles, canAuthWithBiometry: Bool) {
        switch title {
        case .digit(let number):
            keyboardButton.setTitle("\(number)", for: .normal)
        case .biometricAuth:
            keyboardButton.isHidden = !(biometricAuth.canEvaluatePolicy() && canAuthWithBiometry)
            switch biometricAuth.biometricType() {
            case .faceID:
                keyboardButton.setImage(#imageLiteral(resourceName: "icon_faceID"), for: .normal)
            case .touchID:
                keyboardButton.setImage(#imageLiteral(resourceName: "icon_touchID"), for: .normal)
            default:
                keyboardButton.isHidden = true
            }
        case .backspace:
            keyboardButton.setImage(#imageLiteral(resourceName: "icon_backspace"), for: .normal)
        }
    }
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        switchKeyboardButtonPressAction()
    }
    
    func switchKeyboardButtonPressAction() {
        guard let title = self.title else {
            return
        }
        switch title {
        case .biometricAuth:
            self.delegate?.initiateBiometricAuth()
        case .backspace:
            AudioServicesPlaySystemSound(1155)
            self.delegate?.backspaceButtonPressed()
        case .digit(let number):
            AudioServicesPlaySystemSound(1104)
            self.delegate?.addDigitToCode(digit: number)
        }
    }
    
}
