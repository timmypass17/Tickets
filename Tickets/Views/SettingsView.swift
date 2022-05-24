//
//  SettingsView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authStore: ProjectStore
    @State private var name = ""
    @State private var showSignOutDialog = false
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                TextField("Name", text: $name)
            }
            Button("Sign Out", role: .destructive) {
                showSignOutDialog.toggle()
            }
            .confirmationDialog(
                "Log out",
                isPresented: $showSignOutDialog) {
                    Button("Sign out", role: .destructive) {
                        authStore.signOut()
                        showSignOutDialog = false
                    }
                } message: {
                    Text("Are you sure you want to sign out?")
                }

        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
