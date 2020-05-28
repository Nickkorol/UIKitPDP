//
//  ButtonsAnimationViewController.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 27.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

class ButtonsAnimationViewController: UIViewController {
    
    @IBOutlet private var playingView: UIView!
    
    var viewModel: ButtonsAnimationViewModel!
    var buttons = [UIButton]()
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    var timerLabel = UILabel()
    var bestLabel = UILabel()
    var againButton = UIButton()
    
    private var timer: Timer?
    private var timeInterval: TimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let touchLocation = touch?.location(in: self.playingView) else { return }
        checkTouch(for: buttons, touchLocation: touchLocation)
    }
    
}

extension ButtonsAnimationViewController {
    func showSuccessAlert() {
        let alertController = UIAlertController(title: "You won", message: "You've found the right key, your time is \(Int(timeInterval)) seconds", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.timerLabel.isHidden = true
            self.againButton.isHidden = false
            self.timeInterval = 0
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showBlindingView() {
        let blindingView = UIView(frame: CGRect(x: playingView.frame.origin.x, y: playingView.frame.origin.y, width: playingView.frame.width, height: playingView.frame.height))
        blindingView.isOpaque = true
        blindingView.backgroundColor = UIColor(white: 1, alpha: 1)
        playingView.addSubview(blindingView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1.0) {
                blindingView.backgroundColor = UIColor(white: 1, alpha: 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    blindingView.removeFromSuperview()
                }
            }
        }
    }
    
    func checkTouch(for buttons: [UIButton], touchLocation: CGPoint) {
        for index in 0..<buttons.count {
            if ((buttons[index].layer.presentation()?.hitTest(touchLocation)) != nil) {
                if index == 7 {
                    self.stopTimer()
                    buttons.forEach { (button) in
                        button.layer.pause()
                    }
                    viewModel.checkHighScore(newScore: Int(timeInterval))
                    showSuccessAlert()
                } else {
                    showBlindingView()
                }
            }
        }
    }
    
    func configureUI() {
        timerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: playingView.frame.size.width, height: 32))
        bestLabel = UILabel(frame: CGRect(x: 0, y: 0, width: playingView.frame.size.width, height: 32))
        againButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 32))
        againButton.setTitle("Try again", for: .normal)
        againButton.setTitleColor(UIColor.blue, for: .normal)
        againButton.contentHorizontalAlignment = .right
        againButton.addTarget(self, action: #selector(didPressTryAgain(sender:)), for: .touchUpInside)
        againButton.isHidden = true
        
        timerLabel.textAlignment = .right
        bestLabel.textAlignment = .right
        
        playingView.addSubview(timerLabel)
        playingView.addSubview(bestLabel)
        playingView.addSubview(againButton)
        
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        bestLabel.translatesAutoresizingMaskIntoConstraints = false
        againButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: playingView.topAnchor, constant: 32),
            timerLabel.rightAnchor.constraint(equalTo: playingView.rightAnchor, constant: -16),
            timerLabel.leftAnchor.constraint(equalTo: playingView.leftAnchor, constant: 16),
            bestLabel.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 16),
            bestLabel.rightAnchor.constraint(equalTo: playingView.rightAnchor, constant: -16),
            bestLabel.leftAnchor.constraint(equalTo: playingView.leftAnchor, constant: 16),
            againButton.topAnchor.constraint(equalTo: bestLabel.bottomAnchor, constant: 16),
            againButton.rightAnchor.constraint(equalTo: playingView.rightAnchor, constant: -16),
            againButton.leftAnchor.constraint(equalTo: playingView.leftAnchor, constant: 16)
        ])
        
        addButtons()
        startTimer()
    }
    
    func addButtons() {
        for i in 0...20 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            if i == 7 {
                button.setImage(#imageLiteral(resourceName: "golden_key"), for: .normal)
            } else {
                button.setImage(#imageLiteral(resourceName: "black_key"), for: .normal)
            }
            playingView.addSubview(button)
            buttons.append(button)
            
            startPoint = CGPoint(x: 0, y: 0)
            endPoint = getRandomPoint()
            
            addAnimations(startPoint: startPoint, endPoint: endPoint, button: button)
        }
    }
    
    func startTimer() {
        self.timerLabel.text = self.timeInterval.timeString
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                guard let self = self else { return }
                self.timeInterval += 1
                self.timerLabel.text = self.timeInterval.timeString
            })
            self.timer?.fire()
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

private extension ButtonsAnimationViewController {
    func getRandomPoint() -> CGPoint {
        let xStartingPosition = Int(self.playingView.frame.origin.x)
        let xEndingPosition = Int(self.playingView.frame.size.width)
        let yStartingPosition = Int(self.playingView.frame.origin.y)
        let yEndingPosition = Int(self.playingView.frame.size.height)
        let newRandomXFinish = Int.random(in: xStartingPosition..<xEndingPosition)
        let newRandomYFinish = Int.random(in: yStartingPosition..<yEndingPosition)
        let newEndPoint = CGPoint(x: newRandomXFinish, y: newRandomYFinish)
        return newEndPoint
    }
    
    func addAnimations(startPoint: CGPoint, endPoint: CGPoint, button: UIButton) {
        let positionAnimation = constructPositionAnimation(startingPoint: startPoint, endPoint: endPoint)
        
        button.layer.add(positionAnimation, forKey: "position")
        
        let opacityFadeAnimation = constructOpacityAnimation(startingOpacity: 1.0, endingOpacity: 0.1, animationDuration: 1.0)
        button.layer.add(opacityFadeAnimation, forKey: "opacity")
        
        let rotationDuration = Double(Int.random(in: 50..<150)/100)
        
        let rotationAnimation = constructRotationAnimation(animationDuration: rotationDuration)
        button.layer.add(rotationAnimation, forKey: "rotate")
    }
    
    func constructPositionAnimation(startingPoint: CGPoint, endPoint: CGPoint) -> CAKeyframeAnimation {
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        var pathArray = [NSValue]()
        for _ in 1...10 {
            let randomPoint = getRandomPoint()
            pathArray.append(NSValue(cgPoint: randomPoint))
        }
        positionAnimation.values = pathArray
        positionAnimation.duration = CFTimeInterval(Int.random(in: 10...20))
        positionAnimation.autoreverses = true
        positionAnimation.repeatCount = Float.infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return positionAnimation
    }
    
    func constructOpacityAnimation(startingOpacity: CGFloat, endingOpacity: CGFloat, animationDuration: Double) -> CABasicAnimation {
        let opacityFadeAnimation = CABasicAnimation(keyPath: "opacity")
        opacityFadeAnimation.fromValue = startingOpacity
        opacityFadeAnimation.toValue = endingOpacity
        opacityFadeAnimation.duration = animationDuration
        opacityFadeAnimation.autoreverses = true
        opacityFadeAnimation.repeatCount = Float.infinity
        return opacityFadeAnimation
    }
    
    func constructRotationAnimation(animationDuration: Double) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = Double.pi*2
        rotationAnimation.duration = animationDuration
        rotationAnimation.repeatCount = Float.infinity

        return rotationAnimation
    }

    @objc func didPressTryAgain(sender: UIButton) {
        for button in buttons {
            button.layer.removeAllAnimations()
            button.removeFromSuperview()
        }
        buttons.removeAll()
        timerLabel.isHidden = false
        againButton.isHidden = true
        addButtons()
        startTimer()
    }

}

extension ButtonsAnimationViewController: ButtonsAnimationViewInput {
    func resetHighScore(with newResult: Int) {
        bestLabel.text = "Highscore: \(newResult) seconds"
    }
}
