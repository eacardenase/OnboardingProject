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
    private let firstStackView = UIStackView()
    private let secondStackView = UIStackView()
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
        let button = CustomButton(title: "Forgot your password?", subtitle: "Get help signing in.")
        
        button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
        
        return button
    }()
    private let dividerView = DividerView()
    private let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "btn_google_light_pressed_ios")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle(" Log in with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        
        return button
    }()
    private let dontHaveAccountButton: UIButton = {
        let button = CustomButton(title: "Don't have an account?", subtitle: "Sign Up", labelSize: 16)
        
        button.addTarget(self, action: #selector(showRegistrationController), for: .touchUpInside)
        
        return button
    }()
    
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
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstStackView.axis = .vertical
        firstStackView.spacing = 20
        secondStackView.axis = .vertical
        secondStackView.spacing = 28
        
        firstStackView.addArrangedSubview(emailTextField)
        firstStackView.addArrangedSubview(passwordTextField)
        firstStackView.addArrangedSubview(loginButton)
        
        secondStackView.addArrangedSubview(forgotPasswordButton)
        secondStackView.addArrangedSubview(dividerView)
        secondStackView.addArrangedSubview(googleLoginButton)
        
        view.addSubview(iconImage)
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        view.addSubview(dontHaveAccountButton)
        
        // iconImage
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.heightAnchor.constraint(equalTo: iconImage.widthAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // firstStackView
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            firstStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            firstStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        // secondStackView
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 24),
            secondStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            secondStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        // dontHaveAccountButton
        NSLayoutConstraint.activate([
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

    func configureNavigationBar() {
//        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
}

// MARK: - Actions

extension LoginController {
    @objc private func handleLogin(_ sender: UIButton) {
        print("DEBUG: Handle login")
    }
    
    @objc private func showForgotPassword(_ sender: UIButton) {
        let resetPasswordController = ResetPasswordController()
        
        navigationController?.pushViewController(resetPasswordController, animated: true)
    }
    
    @objc private func handleGoogleLogin(_ sender: UIButton) {
        print("DEBUG: Handle login with Google")
    }
    
    @objc private func showRegistrationController(_ sender: UIButton) {
        let registrationController = RegistrationController()
        
        navigationController?.pushViewController(registrationController, animated: true)
    }
}
