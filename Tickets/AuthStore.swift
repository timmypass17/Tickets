//
//  LoginStore.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthStore: ObservableObject {
    // if published variables changes, update views that use this property
    @Published var userSession: FirebaseAuth.User?
    
    let auth = Auth.auth()
    
    init() {
        self.userSession = auth.currentUser
    }
    
    // Checks if user was signed in already
    var isSignedIn: Bool {
        auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.userSession = user
        }
    }
    
    func signUp(name: String, username: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.userSession = user
            
            // Create user object to store into firebase
            let userData = User(uid: user.uid, name: name, email: email, username: username.lowercased())
            
            // Add user to firebase
            do {
                let db = Firestore.firestore()
                try db.collection("users")
                    .document(user.uid)
                    .setData(from: userData)
            } catch {
                print("Error with signing user")
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.userSession = nil
        } catch {
            print("already logged out")
        }
    }
}
