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
                        .onAppear() { /// onAppear gets called twice sometimes, known bug
                            Task {
                                projectStore.refresh()
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
