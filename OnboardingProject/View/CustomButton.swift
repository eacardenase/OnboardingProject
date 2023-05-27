//
//  CustomButton.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/26/23.
//

import UIKit

class CustomButton: UIButton {
    
    convenience init(title: String, subtitle: String, labelSize: CGFloat = 15) {
        self.init(type: .system)
        
        configureUI(title, subtitle, labelSize)
    }
}

// MARK: Helpers

extension CustomButton {
    private func configureUI(_ title: String, _ subtitle: String, _ labelSize: CGFloat) {
        let attributedTitle = NSMutableAttributedString(string: "\(title) ", attributes: [
            .font: UIFont.systemFont(ofSize: labelSize),
            .foregroundColor: UIColor(white: 1, alpha: 0.87)
        ])
        
        attributedTitle.append(NSAttributedString(string: subtitle, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: labelSize)
        ]))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
