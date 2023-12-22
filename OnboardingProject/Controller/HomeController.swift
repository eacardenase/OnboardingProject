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
    
    private var shouldShowOnboarding: Bool = true
    
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
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = MainNavigationController(rootViewController: controller)
            
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
        }
    }
    
    private func presentOnboardingController() {
        DispatchQueue.main.async {
            let controller = OnboardingController()
            
            controller.modalPresentationStyle = .fullScreen
            controller.delegate = self
            
            self.present(controller, animated: true)
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
            print("DEBUG: User is \(user.fullName).")
            print("DEBUG: User has seen onboarding \(user.hasSeenOnboarding).")
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
        shouldShowOnboarding.toggle()
    }
}
