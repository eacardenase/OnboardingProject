//
//  User.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 12/21/23.
//

import Foundation

struct User {
    let email: String
    let fullName: String
    let hasSeenOnboarding: Bool
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.hasSeenOnboarding = dictionary["hasSeenOnboarding"] as? Bool ?? false
    }
}
