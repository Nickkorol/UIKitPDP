//
//  CustomLayerViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 09.04.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class CustomLayerViewController: UIViewController {

    var viewModel: CustomLayerViewModel!
    
    enum FillRule: Int {
      case nonZero, evenOdd
    }

    @IBOutlet private var viewForShapeLayer: UIView!
    @IBOutlet private var fillSwitch: UISwitch!
    @IBOutlet private var fillSegmentedControl: UISegmentedControl!
    @IBOutlet private var lineWidthSlider: UISlider!
    @IBOutlet private var lineDashingSwitch: UISwitch!
    @IBOutlet private var redColorSlider: UISlider!
    @IBOutlet private var greenColorSlider: UISlider!
    @IBOutlet private var blueColorSlider: UISlider!
    
    let shapeLayer = CAShapeLayer()
    var color = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    let bezierPath = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Custom Layer"
        color = UIColor(red: CGFloat(redColorSlider.value), green: CGFloat(greenColorSlider.value), blue: CGFloat(blueColorSlider.value), alpha: 1)
        setUpOpenPath()
        setUpShapeLayer()
        viewForShapeLayer.layer.addSublayer(shapeLayer)
    }

    @IBAction func fillSwitchChanged(_ sender: UISwitch) {
        var selectedSegmentIndex: Int
        
        if sender.isOn {
          shapeLayer.fillColor = color.cgColor
          
            if shapeLayer.fillRule == .nonZero {
            selectedSegmentIndex = FillRule.nonZero.rawValue
          } else {
            selectedSegmentIndex = FillRule.evenOdd.rawValue
          }
        } else {
            selectedSegmentIndex = UISegmentedControl.noSegment
          shapeLayer.fillColor = nil
        }
        
        fillSegmentedControl.selectedSegmentIndex = selectedSegmentIndex
    }
    
    @IBAction func fillSegmentedControlChanged(_ sender: UISegmentedControl) {
        fillSwitch.isOn = true
        shapeLayer.fillColor = color.cgColor
        var fillRule = CAShapeLayerFillRule.nonZero
        
        if sender.selectedSegmentIndex != FillRule.nonZero.rawValue {
            fillRule = CAShapeLayerFillRule.evenOdd
        }
        
        shapeLayer.fillRule = fillRule
    }
    @IBAction func lineWidthSliderValueChanged(_ sender: UISlider) {
        shapeLayer.lineWidth = CGFloat(sender.value)
    }
    @IBAction func lineDashingSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
          shapeLayer.lineDashPattern = [50, 50]
          shapeLayer.lineDashPhase = 25.0
        } else {
          shapeLayer.lineDashPattern = nil
          shapeLayer.lineDashPhase = 0
        }
    }
    
    @IBAction func redSliderChanged(_ sender: UISlider) {
        let red = CGFloat(sender.value)/255
        let color = UIColor(red: red, green: CGFloat(greenColorSlider.value)/255, blue: CGFloat(blueColorSlider.value)/255, alpha: 1)
        shapeLayer.fillColor = fillSwitch.isOn ? color.cgColor : nil
        shapeLayer.strokeColor = color.cgColor
        self.color = color
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        let green = CGFloat(sender.value)/255
        let color = UIColor(red: CGFloat(redColorSlider.value)/255, green: green, blue: CGFloat(blueColorSlider.value)/255, alpha: 1)
        shapeLayer.fillColor = fillSwitch.isOn ? color.cgColor : nil
        shapeLayer.strokeColor = color.cgColor
        self.color = color
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        let blue = CGFloat(sender.value)/255
        let color = UIColor(red: CGFloat(redColorSlider.value)/255, green: CGFloat(greenColorSlider.value)/255, blue: blue, alpha: 1)
        shapeLayer.fillColor = fillSwitch.isOn ? color.cgColor : nil
        shapeLayer.strokeColor = color.cgColor
        self.color = color
    }
}

extension CustomLayerViewController: CustomLayerViewInput {}

extension CustomLayerViewController {
    func setUpOpenPath() {
        let width = viewForShapeLayer.frame.width
        let height = viewForShapeLayer.frame.height - 32
        bezierPath.move(to: CGPoint(x: width/2, y: 16))
        bezierPath.addLine(to: CGPoint(x: width/5, y: height))
        bezierPath.addLine(to: CGPoint(x: width - 16, y: height*0.4))
        bezierPath.addLine(to: CGPoint(x: 16, y: height*0.4))
        bezierPath.addLine(to: CGPoint(x: width*0.8, y: height))
        bezierPath.addLine(to: CGPoint(x: width/2, y: 16))
        bezierPath.close()
    }
    
    func setUpShapeLayer() {
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = nil
        shapeLayer.fillRule = .nonZero
        shapeLayer.lineCap = .butt
        shapeLayer.lineDashPattern = nil
        shapeLayer.lineDashPhase = 0.0
        shapeLayer.lineJoin = .miter
        shapeLayer.lineWidth = CGFloat(lineWidthSlider.value)
        shapeLayer.miterLimit = 4.0
        shapeLayer.strokeColor = color.cgColor
    }
}
