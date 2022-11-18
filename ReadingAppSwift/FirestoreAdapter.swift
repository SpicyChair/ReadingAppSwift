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
    
    func writeToFirestore<T>(key: String, value: T) {
        // generic function to support any type
        if let user = Auth.auth().currentUser {
            let dbUser = db.collection("users")
            dbUser.document(user.uid).setData(
                [
                    key : value,
                ]
            )
            
        }
    }
    
    func readLibraryFromFirestore() {
        if let user = Auth.auth().currentUser {
            // get the reference to the users collection of firestore
            let dbUserRef = db.collection("users").document(user.uid)
            
            dbUserRef.getDocument { document, error in
                // if error occurs
                if let error = error {
                    print(error)
                    return
                }
                
                // else continue
                
                if let document = document {
                    let data = document.data()
                    let library = data?["library"] as? [String] ?? []
                    
                    print(library)
                }
            }
            
        }
    }
    
    
    
}
