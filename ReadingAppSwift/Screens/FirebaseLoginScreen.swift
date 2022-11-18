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
    @State private var isSignedIn = false
    @EnvironmentObject var firestoreAdapter: FirestoreAdapter
    
    @EnvironmentObject var library: LibraryBase
    
    var body: some View {
        NavigationView {
            // if the user is signed in, show them their details
            if isSignedIn {
                profileScreen
            } else {
                // else prompt them to sign in or create an account
                loginScreen
            }
        }
        .navigationViewStyle(.stack)
        
        
        .onAppear(perform: {
                // when the navigationview appears, check if the user is signed in
                Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        print("User is logged in as \(user.email!)")
                        isSignedIn = true
                    } else {
                        print("User is logged out!")
                    }
                    
                }
            }

        )
    }
    
    /*
     LOGIN SCREEN
     
     DISPLAYS IF USER IS LOGGED OUT
     */


    
    var loginScreen :  some View {
    
        Form {
            Section {
                // VStack with account promotional stuff
                VStack (alignment: .leading){
                    Text("Create a free account to")
                        .font(.system(size: 17, weight: .regular, design: .serif))
                    Text(
                    """
                    - Save your library
                    - Save reading progress
                    - Enter reading challenges
                    """
                    ).font(.system(size: 20, weight: .bold, design: .serif))
                }
                
            }
            
            Section ("Already have an account?") {
                // no need for autocap. and autocorrection in a user's email
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                // SecureField hides the text
                SecureField("Password", text: $password)
                 
                 Button(action: {
                      login()
                  }) {
                     Text("Sign in")
                 }
            }

            Section ("No account?") {
                Button(action: {
                     register()
                 }) {
                    Text("Register")
                }
            }
             
        }.navigationTitle("Log In")
        
        
    }
    /*
     PROFILE SCREEN
     
     DISPLAYS IF USER IS LOGGED IN
     */
    
    var profileScreen :  some View {
    
        Form {
            // get the current user
            if let user = Auth.auth().currentUser {
                VStack (alignment: .leading) {
                    Text("Signed in as")
                        .font(.system(size: 17, weight: .regular, design: .serif))
                    Text(user.email ?? "")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                }
            }
            
            Button(action: {
                 logout()
             }) {
                Text("Log Out")
            }
            
            Button(action: {
                firestoreAdapter.writeToFirestore(key: "library", value: library.library)
            }) {
                Text("Sync data")
            }
            
            Button(action: {
                firestoreAdapter.readLibraryFromFirestore()
            }) {
                Text("Read data")
            }
            
            Section ("Warning"){
                Button(action: {
                     deleteAccount()
                 }) {
                    Text("Delete account")
                }.foregroundColor(Color.red)
                
            }
            
            
        }.navigationTitle("Profile")
        
    }
    
    
    
    func login() {
           // use firebase to attempt sign in
           Auth.auth().signIn(withEmail: email, password: password) { result, error in
               if error != nil {
                   print(error?.localizedDescription ?? "")
               } else {
                   print("Success! Logged in as \(email)")
                   isSignedIn = true
               }
           }
    }
    
    func logout() {
        // get instance of firebase
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            isSignedIn = false
        } catch let error {
            print("Error signing out:\n\(error)")
            
        }
    }
    
    func register() {
        // use firebase to attempt to register and sign in
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("Success! Registered as \(email)")
            }
        }
    }
    
    func deleteAccount() {
        // attempt to delete the currently logged in account
        if let user = Auth.auth().currentUser {
            user.delete { error in
                if let error = error {
                    print("\(error)")
                } else {
                    print("Deleted account successfully")
                    isSignedIn = false
                }
                
            }
        }
    }
}




struct FirebaseLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseLoginScreen()
    }
}
