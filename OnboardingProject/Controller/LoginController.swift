//
//  LoginController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 4/11/23.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let iconImage = UIImageView(image: UIImage(named: "firebase-logo"))
    private let stackView = UIStackView()
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password", isSecure: true)
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ])
        
        attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.87),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let dividerView = DividerView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
}

// MARK: - Helpers

extension LoginController {
    func configureUI() {
        configureNavigationBar()
        
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemCyan.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = view.frame
        
        view.layer.addSublayer(gradient)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(forgotPasswordButton)
        stackView.addArrangedSubview(dividerView)
        
        view.addSubview(iconImage)
        view.addSubview(stackView)
        
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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }

    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

// MARK: - Actions

extension LoginController {
    @objc private func handleLogin(_ sender: UIButton) {
        print("DEBUG: Handle login")
    }
    
    @objc private func showForgotPassword(_ sender: UIButton) {
        print("DEBUG: Handle reset password")
    }
}
