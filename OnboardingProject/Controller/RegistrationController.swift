//
//  RegistrationController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/27/23.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let iconImage = UIImageView(image: UIImage(named: "firebase-logo"))
    private let fullNameTextField = CustomTextField(placeholder: "Fullname")
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let signUpButton: UIButton = {
        let button = AuthButton(type: .system)
        
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        
        return button
    }()
    private let alreadyHaveAccountButton: UIButton = {
        let button = CustomButton(title: "Already have an account?", subtitle: "Log In")
        
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - Helpers

extension RegistrationController {
    private func configureUI() {
        configureGradientLayer()
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(fullNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(signUpButton)
        
        view.addSubview(iconImage)
        view.addSubview(stackView)
        view.addSubview(alreadyHaveAccountButton)
        
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
        
        // alreadyHaveAccountButton
        NSLayoutConstraint.activate([
            alreadyHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Actions

extension RegistrationController {
    @objc private func handleSignUp(_ sender: UIButton) -> Void {
        
    }
    
    @objc private func showLoginController(_ sender: UIButton) -> Void {
        navigationController?.popViewController(animated: true)
    }
}
