//
//  AuthService.swift
//  OnboardingProject
//
//  Created by Edwin Cardenas on 5/30/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import GoogleSignIn

struct AuthCredentials {
    let fullName: String
    let email: String
    let password: String
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials, completion: ((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error = error {
                print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
                
                return
            }
            
            guard let uid = result?.user.uid else {
                print("DEBUG: Failed getting uid")
                
                return
            }
            
            let data = [
                "fullName": credentials.fullName,
                "email": credentials.email,
                "uid": uid
            ] as [String: Any]
            
            K.FStore.COLLECTION_USERS.document(uid).setData(data, completion: completion)
        }
    }
    
    static func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func signInWithGoogle(withPresenting controller: UIViewController, completion: ((Error?) -> Void)?) {
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            guard let userID = user.idToken,
                  let userEmail = user.profile?.email,
                  let userName = user.profile?.name
            else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: userID.tokenString,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("DEBUG: Failed to sign in with Google: \(error.localizedDescription)")
                    
                    return
                }
                
                guard let uid = result?.user.uid else {
                    print("DEBUG: Failed getting uid")
                    
                    return
                }
                
                let data = [
                    "fullName": userName,
                    "email": userEmail,
                    "uid": uid
                ] as [String: Any]
                
                K.FStore.COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}
