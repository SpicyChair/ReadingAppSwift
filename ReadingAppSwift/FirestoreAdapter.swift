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
    @Published var libraryFromFirebase:[String] = []
    @Published var challenges: [Challenge] = []
    
    
    @Published var username: String = ""
    
    @Published var users : [String : User] = [:]
    
    // this variable updates every time the  getChallengeParticipants() method is called
    @Published var currentChallengeParticipants : [User] = []
    
    
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
            // merge is true to not overwrite the document
            dbUser.document(user.uid).setData([key : value], merge: true)
        
            
        }
    }
    
    func readLibraryFromFirestore(library: LibraryBase) {
        // return empty array if error / Firestore entry empty
        
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
                    let firebaseLibrary = data?["library"] as? [String] ?? []

                    library.library = firebaseLibrary
                    library.saveLibraryToFile()
                }
            }
        }
    }
    
    func readLogsFromFirebase(bookLogBase: BookLogBase) {
        
        let fileManager = FileManager()
        
        // return empty array if error / Firestore entry empty
        
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
                    // get global page progress and goal as an int
                    let globalPageProgress = data?["globalPageProgress"] as? Int ?? 0
                    let globalPageGoal = data?["globalPageGoal"] as? Int ?? 50
                    // load logged books
                    let loggedBooks = data?["loggedBooks"] as? [String] ?? []
                    let minutesRead = data?["minutesRead"] as? Int ?? 0
                    
                    bookLogBase.globalPageProgress = globalPageProgress
                    bookLogBase.globalPageGoal = globalPageGoal
                    bookLogBase.loggedBooks = loggedBooks
                    bookLogBase.minutesRead = minutesRead
                    
                    
                    // go through each file and then save it locally
                    for file in loggedBooks {
                        if let pages : Int = data?["\(file)_log"] as? Int {
                            fileManager.saveToJSON(filename: "\(file)_log.json" , object: pages)
                        }
                    }
                }
            }
        }
    }
    
    func deleteFirestoreData() {
        if let user = Auth.auth().currentUser {
            
            
            // restore the user name after deletion
            self.getSelfName()
            let name: String = self.username
            
            // get the reference to the users collection of firestore
            let dbUserRef = db.collection("users").document(user.uid)
           
            
            dbUserRef.delete()
            
            // restore the user name after deletion
            self.setName(name: name)
            
        }
    }
    
    func writeLogDataToFireBase(bookLogBase: BookLogBase) {

        
        let fileManager = FileManager()
        
    
        
        writeToFirestore(key: "globalPageProgress", value: bookLogBase.globalPageProgress)
        writeToFirestore(key: "globalPageGoal", value: bookLogBase.globalPageGoal)
        writeToFirestore(key: "loggedBooks", value: bookLogBase.loggedBooks)
        writeToFirestore(key: "minutesRead", value: bookLogBase.minutesRead)

        for file in bookLogBase.loggedBooks {
            
            // load each file from local and then write to firebase
            
            if let data: Int = fileManager.loadJSONFromFile(filename: "\(file)_log.json") {
                writeToFirestore(key: "\(file)_log", value: data)
            }
            
        }
    }
    
    func setName(name: String) {
        self.writeToFirestore(key: "name", value: name)
    }
    
    func getSelfName() {
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
                    self.username = data?["name"] as? String ?? ""
                }
            }
        }
    }
    
    
    func getUsers() {
        // reset users to reflect firestore and clear stale data
        self.users = [:]
            
        self.db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    // extract each field
                    let name = data["name"] as? String ?? "Anonymous"
                    let pageProgress = data["globalPageProgress"] as? Int ?? 0
                    let uid = document.documentID
                    // create new user object
                    let user = User(name: name, uid: uid, pageProgress: pageProgress)
                    // append user object to dictionary
                    self.users.updateValue(user, forKey: uid)
                }
             }
        
        }
    }
    
    
    func createChallenge(title: String, description: String) {
        if let user = Auth.auth().currentUser {
            // access the challenges collection
            let uid = UUID().uuidString
            let challengeRef = db.collection("challenges").document(uid)
            
            // merge is true to not overwrite the document
            // UUID is used to create a unique key
            challengeRef.setData(["description" : description, "title" : title, "createdBy" : user.uid, "uid" : uid], merge: true)
        }
    }
    
    func getChallenges() {
        // reset challenges to reflect firestore and clear stale data
        self.challenges = []
            
        self.db.collection("challenges").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    // extract each field
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let createdBy = data["createdBy"] as? String ?? ""
                    let uid = data["uid"] as? String ?? ""
                    let users = data["users"] as? [String] ?? []
                    
                    // create new Challenge object
                    let challenge = Challenge(title: title, description: description, createdBy: createdBy, uid: uid, users: users)
                    // append Challenge object to array
                    
                    self.challenges.append(challenge)
                }
            }
        
        }
    }
    
    func toggleUserInChallenge(uid: String) {
        
        // toggles whether the user is participating in the challenge or not
        // ie
        // if user not in challenge, join
        // else, leave the challenge
        
        if let user = Auth.auth().currentUser {
            // get the reference to the challenges collection of firestore
            let challengeRef = db.collection("challenges").document(uid)
            
            
            challengeRef.getDocument { document, error in
                // if error occurs
                if let error = error {
                    print(error)
                }
                
                // else continue
                
                if let document = document {
                    let data = document.data()
                    
                    // get the users property of the challenge
                    var challengeUsers = data?["users"] as? [String] ?? []
                    
                    // if the user is already in the challenge
                    if challengeUsers.contains(user.uid) {
                        // remove the user
                        challengeUsers = challengeUsers.filter {$0 != user.uid}
                    } else {
                        // else append the user
                        challengeUsers.append(user.uid)
                    }
                    // set the updated list of users
                    // merge is true to not overwrite the document
                    challengeRef.setData(["users" : challengeUsers], merge: true)
                    self.getChallengeParticipants(uid: uid)
                    
                }
            }
        }
    }
    
    func getChallengeParticipants(uid: String) {
        // get the reference to the challenges collection of firestore
        let challengeRef = db.collection("challenges").document(uid)
        
        challengeRef.getDocument { document, error in
            // if error occurs
            if let error = error {
                print(error)
            }
            
            // else continue
            
            if let document = document {
                let data = document.data()
                
                self.currentChallengeParticipants = []
                // get the users property of the challenge
                let challengeUsers = data?["users"] as? [String] ?? []
                
                for userUID in challengeUsers {
                    if let user = self.users[userUID] {
                        self.currentChallengeParticipants.append(user)
                    }
                }
                // sort the array by the page progress of the user
                self.currentChallengeParticipants = self.currentChallengeParticipants.sorted {
                    $0.pageProgress > $1.pageProgress
                }
            }
        }
        
        
        
    }

    
    

    // account management options
    
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
    
    func register(email: String, password: String, name: String) {
        // use firebase to attempt to register and sign in
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.setName(name: name)
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
