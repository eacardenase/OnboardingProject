//
//  ResetPasswordViewModel.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit

struct ResetPasswordViewModel: AuthenticationViewModelProtocol {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
}
