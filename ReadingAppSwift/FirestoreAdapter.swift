//
//  FirestoreAdapter.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 16/11/2022.
//

import Foundation
import SwiftUI
import Firebase

class FirestoreAdapter : ObservableObject {
    
    var db = Firestore.firestore()
    @Published var isSignedIn = false
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print("User is logged in as \(user.email!)")
                self.isSignedIn = true
            } else {
                print("User is logged out!")
            }
        }
    }
    
    func writeToFirestore<T>(key: String, value: T) {
        // generic function to support any type
        if let user = Auth.auth().currentUser {
            let dbUser = db.collection("users")
            // use the user's uid as document name
            dbUser.document(user.uid).setData(
                [
                    key : value,
                ]
            )
            
        }
    }
    
    func readLibraryFromFirestore() -> [String] {
        // return empty array if error / Firestore entry empty
        var library: [String] = []
        
        if let user = Auth.auth().currentUser {
            // get the reference to the users collection of firestore
            let dbUserRef = db.collection("users").document(user.uid)
            
            dbUserRef.getDocument { document, error in
                // if error occurs
                if let error = error {
                    print(error)
                }
                
                // else continue
                
                if let document = document {
                    let data = document.data()
                    // get library as a string array
                    library = data?["library"] as? [String] ?? []
                    
                    print(library)
                    
                }
            }
        }
        print(library)
        return library
    }
    
    func login(email: String, password: String) {
           // use firebase to attempt sign in
           Auth.auth().signIn(withEmail: email, password: password) { result, error in
               if error != nil {
                   print(error?.localizedDescription ?? "")
               } else {
                   print("Success! Logged in as \(email)")
                   self.isSignedIn = true
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
    
    func register(email: String, password: String) {
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
                    self.isSignedIn = false
                }
                
            }
        }
    }
}
