//
//  AuthFormViewModelProtocol.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import Foundation

protocol AuthFormViewModelProtocol {
    func configureNotificationObservers() -> Void
    func updateForm() -> Void
}
