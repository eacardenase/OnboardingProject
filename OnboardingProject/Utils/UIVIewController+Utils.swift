//
//  UIVIewController+Utils.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit

extension UIViewController {
    func configureGradientLayer() {
        let topColor = UIColor.systemPurple
        let bottomColor = UIColor.systemBlue
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.frame
        
        view.layer.addSublayer(gradientLayer)
    }
}
