//
//  FirebaseLoginScreen.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 15/11/2022.
//

import SwiftUI
import Firebase

struct ProfileScreenView: View {
    
    // user details
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    // if view built before
    @State var didAppear = false
    
    // vars to determine state of sheets and alerts
    @State var showingSheet = false
    @State private var showingAlert = false
    @State private var registering = true
    
    
    // environment objects 
    @EnvironmentObject var adapter: FirestoreAdapter
    @EnvironmentObject var library: LibraryBase
    @EnvironmentObject var bookLogBase: BookLogBase
    
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
        .onAppear {
            // ???
            // toggling the registering property makes the sheet work for some reason
            // ???
            showingSheet = true
            registering.toggle()
            showingSheet = false
        }
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
                }.onAppear {
                    if !didAppear {
                        adapter.getChallenges()
                        didAppear = true
                    }
                    adapter.getUsers()
                }
                
            }
            
            Section ("Already have an account?") {
                Button(action: {
                    // the user is not making a new account
                    self.email = ""
                    self.password = ""
                    self.name = ""
                    self.registering = false
                    self.showingSheet = true
                 }) {
                    Text("Sign in")
                }

            }

            Section ("No account?") {
                Button(action: {
                    // the user IS making a new account
                    self.email = ""
                    self.password = ""
                    self.name = ""
                    self.registering = true
                    self.showingSheet = true
                    
                 }) {
                    Text("Register")
                }
            }
             
        }.navigationTitle("Log In")
            .sheet(isPresented: $showingSheet) {
                Form {
                    // only show if the user is registering
                    if (registering) {
                        TextField("Enter your name", text: $name)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    
                    // no need for autocap. and autocorrection in a user's email
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    
                    // SecureField hides the text
                    SecureField("Password", text: $password)
                    
                    // if the user is registering, then register with name
                    // close the sheet afterwards
                    
                    if (registering) {
                        Button(action: {
                            // Use NOT as failiure returns false -> showAlert = true
                            showingAlert = !adapter.register(email: email, password: password, name: name)
                            // ONLY dismiss when not showing alert
                            if (!showingAlert) {
                                self.showingSheet = false
                            }
                         }) {
                            Text("Register")
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text("Email need to be valid and password needs to have at least 6 characters"), dismissButton: .default(Text("Got it!")))
                        }
                    } else {
                        Button(action: {
                            // Use NOT as failiure returns false -> showAlert = true
                            showingAlert = adapter.login(email: email, password: password)
                            // ONLY dismiss when not showing alert
                            if (!showingAlert) {
                                self.showingSheet = false
                            }
                            
                         }) {
                            Text("Sign in")
                        }
                        
                         .alert(isPresented: $showingAlert) {
                                     Alert(title: Text("Error"), message: Text("Incorrect username or password"), dismissButton: .default(Text("Got it!")))
                        }
                    }
                    
                }
            }
        
        
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
            
            Section ("Change Username") {
                HStack {
                    TextField("Set Username", text: $adapter.username)
                        .frame(maxWidth: Double.infinity)
                    Button("Set") {
                        adapter.setName(name: adapter.username)
                    }.buttonStyle(.bordered)
                    
                }
            }.onAppear (
                perform: adapter.getSelfName
            )
            
            
            Section("Sync Data") {
                Button(action: {
                    adapter.deleteFirestoreData()
                    adapter.writeToFirestore(key: "library", value: library.library)
                    adapter.writeLogDataToFireBase(bookLogBase: bookLogBase)
                    
                    
                }) {
                    Text("Backup data")
                }
                
                Button(action: {
                    adapter.readLibraryFromFirestore(library: library)
                    adapter.readLogsFromFirebase(bookLogBase: bookLogBase)
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
                
                Button(action: {
                    adapter.deleteFirestoreData()
                 }) {
                    Text("Delete synced data")
                }.foregroundColor(Color.red)
            }
            
            
        }.navigationTitle("Profile")
        
    }

}




struct FirebaseLoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreenView()
    }
}
