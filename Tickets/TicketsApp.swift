//
//  TicketsApp.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/17/22.
//

import SwiftUI
import FirebaseCore

@main
struct TicketsApp: App {
    @StateObject private var authStore = AuthStore()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if authStore.userSession != nil {
                    VStack {
                        Text("You are signed in")
                        Button("Sign Out") {
                            authStore.signOut()
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .environmentObject(authStore) // allow rest of app to have access to LoginStore()
        }
    }
}
