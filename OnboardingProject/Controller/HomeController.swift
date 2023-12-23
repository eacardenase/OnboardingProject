//
//  HomeController.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 4/11/23.
//

import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            presentOnboardingIfNeccessary()
            showWelcomeLabel()
        }
    }
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "Welcome!"
        label.alpha = 0
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        configureUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Helpers

extension HomeController {
    private func configureUI() {
        configureGradientLayer()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Firebase Login"
        
        let logoutImage = UIImage(systemName: "person.circle.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(handleLogout))
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = MainNavigationController(rootViewController: controller)
            
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
        }
    }
    
    private func presentOnboardingIfNeccessary() {
        
        guard let user = user else { return }
        guard !user.hasSeenOnboarding else { return }
        
        DispatchQueue.main.async {
            let controller = OnboardingController()
            
            controller.modalPresentationStyle = .fullScreen
            controller.delegate = self
            
            self.present(controller, animated: true)
        }
        
    }
    
    private func showWelcomeLabel() {
        guard let user = user else { return }
        
        self.welcomeLabel.text = "Welcome \(user.fullName)!"
        
        UIView.animate(withDuration: 0.5) {
            self.welcomeLabel.alpha = 1
        }
    }
}

// MARK: - API

extension HomeController {
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            fetchUser()
        }
        
    }
    
    private func logout(_ alertAction: UIAlertAction) -> Void {
        AuthService.logUserOut {
            presentLoginController()
        }
    }
    
    private func fetchUser() {
        AuthService.fetchUser { user in
            self.user = user
        }
    }
}

// MARK: - Actions

extension HomeController {
    @objc private func handleLogout() {
        let ac = UIAlertController(title: nil, message: "Are your sure you want to log out?", preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: self.logout))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

// MARK: - OnboardingControllerDelegate

extension HomeController: OnboardingControllerDelegate {
    func controllerWantsToDismiss(_ controller: OnboardingController) {
        controller.dismiss(animated: true)
        
        AuthService.updateUserHasSeenOnboarding { error in
            if let error = error {
                print("DEBUG: Error updating user hasSeenOnboarding with error \(error.localizedDescription)")
            }
            
            print("DEBUG: Did set hasSeenOnboarding")
            self.user?.hasSeenOnboarding = true
        }
    }
}
