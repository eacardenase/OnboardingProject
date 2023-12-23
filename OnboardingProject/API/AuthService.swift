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
                "hasSeenOnboarding": false
            ] as [String: Any]
            
            K.FStore.COLLECTION_USERS.document(uid).setData(data, completion: completion)
        }
    }
    
    static func logUserIn(withEmail email: String, password: String, completion: ((AuthDataResult?, Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func logUserOut(_ completion: () -> Void) {
        do {
            try Auth.auth().signOut()
            
            completion()
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
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
                
                K.FStore.COLLECTION_USERS.document(uid).getDocument { snapshot, error in
                    guard let userData = snapshot, let userExist = snapshot?.exists else { return }
                    
                    var data = [
                        "fullName": userName,
                        "email": userEmail,
                    ] as [String: Any]
                    
                    if !userExist {
                        data["hasSeenOnboarding"] = false
                    } else {
                        data["hasSeenOnboarding"] = userData.get("hasSeenOnboarding") as? Bool
                    }
                    
                    K.FStore.COLLECTION_USERS.document(uid).setData(data, completion: completion)
                }
            }
        }
    }
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        K.FStore.COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: error \(error.localizedDescription)")
            }
            
            guard let userData = snapshot?.data() else { return }
            let user = User(uid: uid, dictionary: userData)
                        
            completion(user)
        }
    }
    
    static func updateUserHasSeenOnboarding(completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        K.FStore.COLLECTION_USERS.document(uid).setData(["hasSeenOnboarding" : true], merge: true, completion: completion)
    }
}
