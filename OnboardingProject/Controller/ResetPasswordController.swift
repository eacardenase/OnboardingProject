//
//  ResetPasswordController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/29/23.
//

import UIKit

class ResetPasswordController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage = UIImageView(image: UIImage(named: "firebase-logo"))
    private let stackView = UIStackView()
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let resetPasswordButton: UIButton = {
        let button = AuthButton()
        
        button.setTitle("Send Reset Link", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        
        return button
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)

        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension ResetPasswordController {
    private func configureUI() {
        
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemCyan.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = view.frame
        
        view.layer.addSublayer(gradient)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(resetPasswordButton)
        
        view.addSubview(backButton)
        view.addSubview(iconImage)
        view.addSubview(stackView)
        
        // backButton
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        // iconImage
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
}

// MARK: - Actions

extension ResetPasswordController {
    
    @objc private func handleResetPassword(_ sender: UIButton) -> Void {
        print("DEBUG: Handle reset password")
    }
    
    @objc private func handleDismissal(_ sender: UIButton) -> Void {
        navigationController?.popViewController(animated: true)
    }
}
