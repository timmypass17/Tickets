//
//  LoginStore.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import Foundation
import FirebaseAuth

class LoginStore: ObservableObject {
    let auth = Auth.auth()
    
    // if published variables changes, update views that use this property
    @Published var signedIn = false
    
    // Checks if user was signed in already
    var isSignedIn: Bool {
        auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Success
            self.signedIn = true
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Success
            self.signedIn = true
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.signedIn = false
        } catch {
            print("already logged out")
        }
    }
}
