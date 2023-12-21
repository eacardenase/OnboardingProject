//
//  OnboardingControllerDelegate.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 12/21/23.
//

import Foundation

protocol OnboardingControllerDelegate: AnyObject {
    func controllerWantsToDismiss(_ controller: OnboardingController)
}
