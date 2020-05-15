//
//  AppDelegate.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = AppCoordinatorImpl(root: window)
        coordinator?.run()
        return true
    }

}

