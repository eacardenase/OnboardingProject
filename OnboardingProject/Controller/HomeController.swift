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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        configureUI()
    }
    
}

// MARK: - Helpers

extension HomeController {
    private func configureUI() {
        configureGradientLayer()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "Firebase Login"
        
        let logoutImage = UIImage(systemName: "person.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoutImage, style: .plain, target: self, action: #selector(handleLogout))
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            
            nav.modalPresentationStyle = .fullScreen
            
            self.present(nav, animated: true)
        }
    }
    
    private func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            print("DEBUG: User is logged in!")
        }
    }
}

// MARK: - Actions

extension HomeController {
    @objc private func handleLogout() {
        do {
            try Auth.auth().signOut()
            
            presentLoginController()
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
}
