//
//  PanelTransition.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 13.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = TransitionDriver()
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)
        let presentationController = DimmPresentationController(presentedViewController: presented,
                                                               presenting: presenting ?? source)
        presentationController.driver = driver
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return driver
    }
    
}
