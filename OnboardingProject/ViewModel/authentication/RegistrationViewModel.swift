//
//  RegistrationViewModel.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import Foundation

struct RegistrationViewModel: AuthenticationViewModelProtocol {
    var fullName: String?
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return fullName?.isEmpty == false
        && email?.isEmpty == false
        && password?.isEmpty == false
    }
}
