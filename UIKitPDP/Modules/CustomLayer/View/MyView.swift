//
//  MyView.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 26.06.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import UIKit

class MyView: UIView {
    
    let bezierPath = UIBezierPath()
    
    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let layer = self.layer as? CAShapeLayer {
            setUpOpenPath()
            layer.path = bezierPath.cgPath
        } 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpOpenPath() {
        let width = self.frame.width
        let height = self.frame.height - 32
        bezierPath.move(to: CGPoint(x: width/2, y: 16))
        bezierPath.addLine(to: CGPoint(x: width/5, y: height))
        bezierPath.addLine(to: CGPoint(x: width - 16, y: height*0.4))
        bezierPath.addLine(to: CGPoint(x: 16, y: height*0.4))
        bezierPath.addLine(to: CGPoint(x: width*0.8, y: height))
        bezierPath.addLine(to: CGPoint(x: width/2, y: 16))
        bezierPath.close()
    }
}
