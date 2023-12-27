//
//  UIVIewController+Utils.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func configureGradientLayer() {
        let topColor = UIColor.systemPurple
        let bottomColor = UIColor.systemBlue
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.frame
        
        view.layer.addSublayer(gradientLayer)
    }
    
    func showLoader(_ show: Bool) -> Void {
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
}
