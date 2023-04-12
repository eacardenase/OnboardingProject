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
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        let spacer = UIView()
        
        spacer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spacer.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.rightView = spacer
        textField.rightViewMode = .always
        
        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark // gives us a dark keyboard
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField() 
        let spacer = UIView()
        
        spacer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spacer.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        textField.leftView = spacer
        textField.leftViewMode = .always
        textField.rightView = spacer
        textField.rightViewMode = .always

        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.7)
        ])
        
        return textField
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
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
