//
//  PopUpViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 10.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    var viewModel: PopUpViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifications()
        contentView.layer.cornerRadius = 24
    }
    
    @IBAction func readyButtonDidPress(_ sender: UIButton) {
        guard let text = textField.text else { return }
        viewModel.doneButtonDidPress(text: text)
    }
    
}

extension PopUpViewController: PopUpViewInput {}

extension PopUpViewController {
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWillChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }

        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let options = UIView.AnimationOptions(rawValue: curve << 16)

        let moveUp = (notification.name == UIResponder.keyboardWillShowNotification)

        contentViewBottomConstraint.constant = moveUp ? keyboardHeight : 0

        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
