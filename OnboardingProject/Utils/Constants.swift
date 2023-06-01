//
//  Constants.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/30/23.
//

import FirebaseFirestore

struct K {
    struct FStore {
        static let COLLECTION_USERS = Firestore.firestore().collection("users")
    }
    
    struct Onboarding {
        static let MSG_METRICS = "Metrics"
        static let MSG_DASHBOARD = "Dashboard"
        static let MSG_NOTIFICATIONS = "Get Notified"
        
        static let MSG_ONBOARDING_METRICS = "Extract valuable insights and come up with data driven product initiatives to help grow your business"
        static let MSG_ONBOARDING_DASHBOARD = "Everything you need all in one place, available through our dashboard feature"
        static let MSG_ONBOARDING_NOTIFICATIONS = "Get notified when important stuff is happening, so you don't miss out on the action"
    }
}
