//
//  ResetPasswordViewModel.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import Foundation

struct ResetPasswordViewModel {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
}
