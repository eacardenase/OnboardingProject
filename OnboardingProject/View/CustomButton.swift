//
//  CustomButton.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/26/23.
//

import UIKit

class CustomButton: UIButton {

    private let title: String
    private let subtitle: String
    private let type: ButtonType
    private let labelSize: CGFloat
    
    init(title: String, subtitle: String, type: ButtonType, labelSize: CGFloat = 15) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.labelSize = labelSize
        
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Helpers

extension CustomButton {
    private func configureUI() {
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
