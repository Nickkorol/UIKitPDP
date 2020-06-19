//
//  KeyboardView.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 05.06.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import UIKit

@IBDesignable
class KeyboardView: UIView {
    
    @IBInspectable var cellBackgroundColor: UIColor = .white {
        didSet {
        }
    }
    
    @IBInspectable var cellFontColor: UIColor = .black {
        didSet {
        }
    }
    
    @IBInspectable var cellFontSize: CGFloat = 12.0 {
        didSet {
        }
    }
    
    @IBInspectable var enterCollectionViewBackgroundColor: UIColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1) {
        didSet{
            firstCollectionView.backgroundColor = enterCollectionViewBackgroundColor
        }
    }
    
    @IBInspectable var confirmCollectionViewBackgroundColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) {
        didSet{
            secondCollectionView.backgroundColor = confirmCollectionViewBackgroundColor
        }
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(frame: self.bounds)
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 28
        view.contentMode = .scaleToFill
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        return label
    }()
    
    var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтвердите код"
        return label
    }()
    
    lazy var firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: layout)
        view.isScrollEnabled = false
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
    }()
    
    lazy var secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: layout)
        view.isScrollEnabled = false
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
    }()
    
    private var sizingLabel = UILabel(frame: .zero)
    lazy var collectionView: UICollectionView = {
        let layout = KeyboardCollectionViewLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: layout)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
    }()
    
    var pinCode = ""
    var confirmCode = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup(){
        self.addSubview(firstCollectionView)
        firstCollectionView.backgroundColor = enterCollectionViewBackgroundColor
        firstCollectionView.register(VerificationCollectionViewCell.self, forCellWithReuseIdentifier: "verificationCell")
        secondCollectionView.backgroundColor = confirmCollectionViewBackgroundColor
        secondCollectionView.register(VerificationCollectionViewCell.self, forCellWithReuseIdentifier: "verificationCell")
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: "keyboardCell")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstCollectionView.translatesAutoresizingMaskIntoConstraints = false
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(firstCollectionView)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(secondCollectionView)
        stackView.addArrangedSubview(collectionView)
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            firstCollectionView.heightAnchor.constraint(equalToConstant: 50),
            firstCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            firstCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            secondCollectionView.heightAnchor.constraint(equalToConstant: 50),
            secondCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            secondCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}

extension KeyboardView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return 12
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.firstCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verificationCell", for: indexPath) as? VerificationCollectionViewCell else { fatalError() }
            cell.configure(index: indexPath.item, pinCode: pinCode)
            return cell
        } else if collectionView == self.secondCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verificationCell", for: indexPath) as? VerificationCollectionViewCell else { fatalError() }
            cell.configure(index: indexPath.item, pinCode: confirmCode)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "keyboardCell", for: indexPath) as? KeyboardCollectionViewCell else { fatalError() }
            cell.configure(index: indexPath.item, canAuthWithBiometry: true, backgroundColor: cellBackgroundColor, cellFontColor: cellFontColor, cellFontSize: cellFontSize)
            cell.delegate = self
            return cell
            
        }
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}

extension KeyboardView: KeyboardCollectionViewCellDelegate {
    func addDigitToCode(digit: Int) {
        if pinCode.count < 4 {
            pinCode.append("\(digit)")
            firstCollectionView.reloadData()
        } else if confirmCode.count < 4 {
            confirmCode.append("\(digit)")
            secondCollectionView.reloadData()
            if (pinCode.count == 4 && confirmCode.count == 4) {
                checkCodesEquality()
            }
        }
    }
    
    func backspaceButtonPressed() {
        if confirmCode.count > 0 {
            confirmCode = String(confirmCode.dropLast())
            secondCollectionView.reloadData()
        } else if pinCode.count > 0 {
            pinCode = String(pinCode.dropLast())
            firstCollectionView.reloadData()
        }
    }
    
    func initiateBiometricAuth() {
        print("Biometry")
    }
}

private extension KeyboardView {
    func checkCodesEquality() {
        let message = pinCode == confirmCode ? "Codes are equal" : "Codes are not equal"
        let alertController = UIAlertController(title: "Code checking", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.clearCodes()
        })
        alertController.addAction(action)
        self.window?.rootViewController?.present(alertController, animated: true)
    }
    
    func clearCodes() {
        pinCode = ""
        confirmCode = ""
        firstCollectionView.reloadData()
        secondCollectionView.reloadData()
    }
}
