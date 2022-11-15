//
//  FirebaseLoginScreen.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 15/11/2022.
//

import SwiftUI
import Firebase

struct FirebaseLoginScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            Form {
               VStack {
                   // no need for autocap. and autocorrection in a user's email
                   TextField("Email", text: $email)
                       .autocapitalization(.none)
                       .disableAutocorrection(true)
                   // SecureField hides the text
                   SecureField("Password", text: $password)
                   
               }
                
                Button(action: {
                     login()
                 }) {
                    Text("Sign in")
                }
                
                Button(action: {
                     logout()
                 }) {
                    Text("Log Out")
                }
                
                Button(action: {
                     register()
                 }) {
                    Text("Register")
                }
            }
            .navigationTitle("Login")
            .onAppear(perform: {
                
                Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        print("User is logged in as \(user.email!)")
                    } else {
                        print("User is logged out!")
                    }
                    
                }
            })
        }.navigationViewStyle(.stack)
    }

    func login() {
           // use firebase to attempt sign in
           Auth.auth().signIn(withEmail: email, password: password) { result, error in
               if error != nil {
                   print(error?.localizedDescription ?? "")
               } else {
                   print("Success! Logged in as \(email)")
               }
           }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let error {
            print("Error signing out:\n\(error)")
        }
    }
    
    func register() {
        // use firebase to attempt sign in
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Success! Registered as \(email)")
            }
        }
    }
}




struct FirebaseLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseLoginScreen()
    }
}
