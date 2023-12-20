//
//  RegistrationController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/27/23.
//

import UIKit
import FirebaseAuth

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = RegistrationViewModel()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        
        return button
    }()
    private let firstStackView = UIStackView()
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
    private let secondStackView = UIStackView()
    private let dividerView = DividerView()
    private let alreadyHaveAccountButton: UIButton = {
        let button = CustomButton(title: "Already have an account?", subtitle: "Log In")
        
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObservers()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Helpers

extension RegistrationController {
    private func configureUI() {
        configureGradientLayer()
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        firstStackView.axis = .vertical
        firstStackView.spacing = 20
        secondStackView.axis = .vertical
        secondStackView.spacing = 28
        
        firstStackView.addArrangedSubview(fullNameTextField)
        firstStackView.addArrangedSubview(emailTextField)
        firstStackView.addArrangedSubview(passwordTextField)
        firstStackView.addArrangedSubview(signUpButton)
        
        secondStackView.addArrangedSubview(dividerView)
        
        view.addSubview(backButton)
        view.addSubview(iconImage)
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        view.addSubview(alreadyHaveAccountButton)
        
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
            firstStackView.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            firstStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            firstStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
        
        // secondStackView
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 24),
            secondStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            secondStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
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
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullName = fullNameTextField.text else { return }
        
        let credentials = AuthCredentials(fullName: fullName, email: email.lowercased(), password: password)
        
        AuthService.registerUser(withCredentials: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to upload user data with error: \(error.localizedDescription)")
                
                let ac = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(ac, animated: true)
                
                return
            }
            
            self.dismiss(animated: true)
        }
    }
    
    @objc private func showLoginController(_ sender: UIButton) -> Void {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChange(_ sender: UITextField) -> Void {
        if sender == fullNameTextField {
            viewModel.fullName = sender.text
        } else if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
}

// MARK: - AuthFormViewModelProtocol

extension RegistrationController: AuthFormViewModelProtocol {
    func configureNotificationObservers() -> Void {
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func updateForm() -> Void {
        signUpButton.isEnabled = viewModel.shouldEnableButton
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
    }
}
