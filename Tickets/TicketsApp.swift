//
//  TicketsApp.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/17/22.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct TicketsApp: App {
    @StateObject private var projectStore = ProjectStore()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if projectStore.isSignedIn {
                    ProjectsListView()
                        .onAppear {
                            Task {
                                projectStore.fetchUser(user: Auth.auth().currentUser!)
                                print("ProjectsListView: OnAppear")
                            }
                        }
                } else {
                    LoginView()
                }
            }
            .environmentObject(projectStore) // allow rest of app to have access to ProjectStore()
        }
    }
}
