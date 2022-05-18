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
    @StateObject private var loginStore = LoginStore()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if loginStore.signedIn || loginStore.isSignedIn {
                    VStack {
                        Text("You are signed in")
                        Button("Sign Out") {
                            loginStore.signOut()
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .environmentObject(loginStore) // allow rest of app to have access to LoginStore()
        }
    }
}
