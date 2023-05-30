//
//  AuthenticationViewModelProtocol.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit

protocol AuthenticationViewModelProtocol {
    var formIsValid: Bool { get }
    var shouldEnableButton: Bool { get }
    var buttonTitleColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
}

extension AuthenticationViewModelProtocol {
    var shouldEnableButton: Bool {
        return formIsValid
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? AuthButton.enabledTitleColor
        : AuthButton.disabledTitleColor
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? AuthButton.enabledBackgroundColor
        : AuthButton.disabledBackgroundColor
    }
}
