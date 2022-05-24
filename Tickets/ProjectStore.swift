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

class ProjectStore: ObservableObject {
    // if published variables changes, update views that use this property
    @Published var currentUser = User()
    @Published var projects: [Project] = []
    @Published var isSignedIn = Auth.auth().currentUser != nil
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.isSignedIn = true
            self.fetchUser(user: user)
        }
    }
    
    func signUp(name: String, username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            guard let user = result?.user else { return }
            self.isSignedIn = true

            // Create user object to store into firebase
            let userData = User(uid: user.uid, name: name, email: email, username: username.lowercased(), projects: [])
            
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
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.currentUser = User()
            self.projects = []
        } catch {
            print("already logged out")
        }
    }
    
    // Updates user data
    func fetchUser(user: FirebaseAuth.User) {
        Firestore.firestore().collection("users")
            .document(user.uid)
            .getDocument { (document, error) in
                guard let document = document else { return }
                guard let user = try? document.data(as: User.self) else { return }
                
                self.currentUser = user
                self.fetchProjects(user: user)
            }
    }
    
    // Note: adds project document + updates user's projects variable
    func addProject(project: Project) async {
        do {
            let db = Firestore.firestore()
            // Add project document
            try db.collection("projects")
                .document(project.projectID)
                .setData(from: project)
            
            // Update projects
            var currentProjects: [String] = self.currentUser.projects
            currentProjects.append(project.projectID)
            // Update user's projects in firebase
            try await db.collection("users")
                .document(self.currentUser.uid)
                .updateData(["projects": currentProjects])
            
            self.projects.append(project) // @MainActor needed here, cant update @Publish from async call?
        } catch {
            print("error getting project from firebase")
        }
    }
    
    func fetchProjects(user: User) {
        print("Calling fetch projects")
        self.projects.removeAll()
        // Iterate through user's projects id
        for id in user.projects {
            getProject(id: id)
        }
    }
    
    // GET project from firebase
    func getProject(id: String) {
        let db = Firestore.firestore()
        db.collection("projects")
            .document(id)
            .getDocument { (document, error) in
                guard let document = document else { return }
                guard let project = try? document.data(as: Project.self) else { return }
                
                self.projects.append(project) // Add to array
//                self.projects.sorted(by: <#T##(Project, Project) throws -> Bool#>) // sort by due date
            }
        }

}
