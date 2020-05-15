//
//  BiometricAuthentication.swift
//  UIKitPDP
//
//  Created by Nikita Korolev on 15.05.2020.
//  Copyright © 2020 Никита Королев. All rights reserved.
//

import Foundation
import LocalAuthentication

enum BiometricType {
    case none
    case touchID
    case faceID
}

enum BiometricAuthResult {
    case success
    case failure(message: BiometricAuthResultError)
}

enum BiometricAuthResultError {
    case authFailed
    case userCancel
    case userFallback
    case userDenied
}

class BiometricIDAuth {
    let context = LAContext()
    var loginReason = "Приложите палец"
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func biometricType() -> BiometricType {
        context.localizedFallbackTitle = "Введите 4-значный пароль"
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            loginReason = "Посмотрите на экран"
            return .faceID
        }
    }
    
    func authenticateUser(completion: @escaping (BiometricAuthResult?) -> Void) {
        guard canEvaluatePolicy() else {
            completion(.failure(message: .userDenied))
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: loginReason) { (success, evaluateError) in
                                if success {
                                    DispatchQueue.main.async {
                                        completion(.success)
                                    }
                                } else {
                                    let message: BiometricAuthResultError
                                    switch evaluateError {
                                    case LAError.authenticationFailed?:
                                        message = .authFailed
                                    case LAError.userCancel?:
                                        message = .userCancel
                                    case LAError.userFallback?:
                                        message = .userFallback
                                    case LAError.biometryNotAvailable?:
                                        message = .userDenied
                                    default:
                                        message = .userFallback
                                    }
                                    DispatchQueue.main.async {
                                        completion(.failure(message: message))
                                    }
                                }
        }
    }
}
