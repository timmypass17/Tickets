//
//  LoginStore.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import Foundation
import FirebaseAuth

class AuthStore: ObservableObject {
    // if published variables changes, update views that use this property
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    // Checks if user was signed in already
    var isSignedIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.userSession = user
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.userSession = user
            
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print("already logged out")
        }
    }
}
