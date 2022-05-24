//
//  LoginView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authStore: ProjectStore
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
            }
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
            
            Button("Login") {
                authStore.signIn(email: email, password: password)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            HStack {
                Text("Don't have an account?")
                NavigationLink(destination: SignupView()) {
                    Text("Sign up")
                }
            }
            .font(.subheadline)
            Spacer()
        }
        .navigationTitle("Login")
        .padding()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
