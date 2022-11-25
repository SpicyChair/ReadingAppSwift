//
//  FirebaseLoginScreen.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 15/11/2022.
//

import SwiftUI
import Firebase

struct ProfileScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    //@State private var isSignedIn = false
    
    // environment objects 
    @EnvironmentObject var adapter: FirestoreAdapter
    @EnvironmentObject var library: LibraryBase
    
    var body: some View {
        NavigationView {
            // if the user is signed in, show them their details
            if adapter.isSignedIn {
                profileScreen
            } else {
                // else prompt them to sign in or create an account
                loginScreen
            }
        }
        .navigationViewStyle(.stack)
    
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
                     adapter.login(email: email, password: password)
                  }) {
                     Text("Sign in")
                 }
            }

            Section ("No account?") {
                Button(action: {
                    adapter.register(email: email, password: password)
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
                adapter.logout()
             }) {
                Text("Log Out")
            }
            
            Section("Sync Data") {
                Button(action: {
                    adapter.writeToFirestore(key: "library", value: library.library)
                    
                }) {
                    Text("Backup data")
                }
                
                Button(action: {
                    adapter.readLibraryFromFirestore(library: library)
                }) {
                    Text("Overwrite local data with backup")
                }
            }
            
            
            Section ("Warning"){
                Button(action: {
                    adapter.deleteAccount()
                 }) {
                    Text("Delete account")
                }.foregroundColor(Color.red)
                
            }
            
            
        }.navigationTitle("Profile")
        
    }

}




struct FirebaseLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
