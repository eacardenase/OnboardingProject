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
    
    private func logout(_ alertAction: UIAlertAction) -> Void {
        do {
            try Auth.auth().signOut()
            
            presentLoginController()
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
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
