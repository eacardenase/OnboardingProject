//
//  LoginViewModel.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
    }
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
