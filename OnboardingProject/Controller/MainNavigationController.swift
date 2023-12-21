//
//  OnboardingNavigationController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 12/21/23.
//

import UIKit

class MainNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
