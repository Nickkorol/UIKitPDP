//
//  MainContainer.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class MainContainer: UINavigationController {

    override func show(_ vc: UIViewController, sender: Any?) {
        pushViewController(vc, animated: true)
    }

}
