//
//  KeyboardCollectionViewCell.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 05.06.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit
import AudioToolbox

enum PinCodeKeyboardTitles {
    case digit(number: Int)
    case biometricAuth
    case backspace
}

protocol KeyboardCollectionViewCellDelegate: class {
    func addDigitToCode(digit: Int)
    func backspaceButtonPressed()
    func initiateBiometricAuth()
}

class KeyboardCollectionViewCell: UICollectionViewCell {
    
    private let biometricAuth = BiometricIDAuth()
    private var title: PinCodeKeyboardTitles?
    weak var delegate: KeyboardCollectionViewCellDelegate?

    lazy var keyboardButton : UIButton = {
        let button = UIButton(frame: self.bounds)
        button.addTarget(self, action: #selector(keyboardButtonPressed(sender:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(keyboardButton)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(keyboardButton)
    }

    func configure(index: Int, canAuthWithBiometry: Bool, backgroundColor: UIColor, cellFontColor: UIColor, cellFontSize: CGFloat) {
        keyboardButton.setTitle("", for: .normal)
        keyboardButton.setImage(nil, for: .normal)
        keyboardButton.backgroundColor = backgroundColor
        keyboardButton.setTitleColor(cellFontColor, for: .normal)
        keyboardButton.titleLabel?.font = UIFont.systemFont(ofSize: cellFontSize)
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
                keyboardButton.setImage(UIImage(named: "icon_faceID"), for: .normal)
            case .touchID:
                keyboardButton.setImage(UIImage(named: "icon_touchID"), for: .normal)
            default:
                keyboardButton.isHidden = true
            }
        case .backspace:
            keyboardButton.setImage(UIImage(named: "icon_backspace"), for: .normal)
        }
    }
    
    @objc func keyboardButtonPressed(sender: UIButton) {
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
