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
    
    func readFromFirestore(docPath: String) {
        if let user = Auth.auth().currentUser {
            let dbUser = db.collection("users")
            
        }
    }
    
    
    
}
