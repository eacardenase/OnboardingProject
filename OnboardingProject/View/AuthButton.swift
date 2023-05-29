//
//  AuthButton.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 4/12/23.
//

import UIKit

class AuthButton: UIButton {
    
    static let enabledBackgroundColor = UIColor(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    static let disabledBackgroundColor = UIColor(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    static let enabledTitleColor = UIColor.white
    static let disabledTitleColor = UIColor(white: 1, alpha: 0.67)
    
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
        backgroundColor = Self.disabledBackgroundColor
        setTitleColor(Self.disabledTitleColor, for: .normal)
        isEnabled = false
        layer.cornerRadius = 5
    }
}
