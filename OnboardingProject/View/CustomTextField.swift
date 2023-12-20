//
//  CustomTextField.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 4/12/23.
//

import UIKit

class CustomTextField: UITextField {

    private let placeholderText: String
    private let isSecure: Bool

    init(placeholder: String, isSecure: Bool = false) {
        self.placeholderText = placeholder
        self.isSecure = isSecure

        super.init(frame: .zero)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 200, height: 50) // stack views would know how to handle its width
    }
}

// MARK: - Helpers

extension CustomTextField {
    private func configureUI() {
        let spacer = UIView()
        
        NSLayoutConstraint.activate([
            spacer.heightAnchor.constraint(equalToConstant: 50),
            spacer.widthAnchor.constraint(equalToConstant: 12)
        ])

        leftView = spacer
        leftViewMode = .always
        rightView = spacer
        rightViewMode = .always

        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark // gives us a dark keyboard
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        layer.cornerRadius = 5
        isSecureTextEntry = isSecure
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
    }
}
