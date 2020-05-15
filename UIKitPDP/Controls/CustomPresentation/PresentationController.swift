//
//  PresentationController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 13.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeight = bounds.height / 2
        return CGRect(x: 0,
                             y: halfHeight,
                             width: bounds.width,
                             height: halfHeight)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    var driver: TransitionDriver!
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            driver.direction = .dismiss
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
