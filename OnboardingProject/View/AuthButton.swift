//
//  AuthButton.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 4/12/23.
//

import UIKit

class AuthButton: UIButton {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 50)
    }
}

// MARK: - Helpers

extension AuthButton {
    
    private func configureUI() {
        backgroundColor = UIColor(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        isEnabled = false
        layer.cornerRadius = 5
    }
}
