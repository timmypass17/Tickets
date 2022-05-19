//
//  SignupView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var authStore: AuthStore
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Name", text: $name)
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            
            Button("Sign up") {
                authStore.signUp(name: name, username: username, email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Spacer()
        }
        .navigationTitle("Sign up")
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignupView()
        }
    }
}
