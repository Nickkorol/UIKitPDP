//
//  KeyboardViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 20.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {
    
    var viewModel: KeyboardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension KeyboardViewController: KeyboardViewInput {}
