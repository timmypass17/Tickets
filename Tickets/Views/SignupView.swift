//
//  SignupView.swift
//  Tickets
//
//  Created by Timmy Nguyen on 5/18/22.
//

import SwiftUI

struct SignupView: View {
    
    @EnvironmentObject var authStore: AuthStore
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
            
            Button("Sign up") {
                authStore.signUp(email: email, password: password)
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
