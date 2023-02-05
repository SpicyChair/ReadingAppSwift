//
//  SocialScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SocialScreenView: View {
    
    @EnvironmentObject var adapter: FirestoreAdapter
    @State var didAppear = false
    @State private var showingSheet = false
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                if (!adapter.isSignedIn) {
                    Text("Sign in to participate in challenges!")
                } else if !adapter.challenges.isEmpty {
                    List {
                        ForEach(adapter.challenges, id: \.self) { challenge in
                            
                            ChallengeCard(challenge: challenge)
                        }
                        
                    }
                    
                }
                
                Section("Leaderboard") {
                    
                    
                    // get the values of the user dict as an array, then sort it
                    
                    // the id is the index 1 of the (index, userID) array
                    // ie the string
                    
                    // enumerated returns an indexed version
                    
                    if let users = Array(adapter.users.values).sorted {$0.pageProgress > $1.pageProgress} {
                        ForEach(Array(users.enumerated()), id: \.1.self) { (index, user) in
                            NavigationLink(destination: UserScreenView(user: user)) {
                                LeaderboardCard(username: user.name, count: user.pageProgress, place: index + 1)
                            }
                                
                        }
                    }
                    
                    
                }

            }
            // get challenges when view appears
            // or user pulls down
            .refreshable {
                adapter.getUsers()
                adapter.getChallenges()
            }
            .onAppear {
                if !didAppear {
                    adapter.getChallenges()
                    didAppear = true
                }
                adapter.getUsers()
                
            }
            .toolbar {
                
                if (adapter.isSignedIn) {
                    Button("Add") {
                        self.showingSheet = true
                    }
                }
                
            }
            .navigationViewStyle(.stack)
            .navigationTitle("Social")
            .sheet(isPresented: $showingSheet) {
            
                    Form {
                        Text("Add Challenge")
                            .font(.system(size: 20, weight: .bold, design: .serif))

                        TextField("Title", text: $title)
                                .disableAutocorrection(true)
                        
                        Text("Add a description below!")
                            .foregroundColor(.gray)
                        TextEditor(text: $description)

                        Button(action: {
                            adapter.createChallenge(title: title, description: description)
                            // reset values of title and description
                            self.title = ""
                            self.description = ""
                            // hide the sheet and refresh
                            self.showingSheet = false
                            adapter.getChallenges()
                            adapter.getUsers()
                          }) {
                             Text("Create Challenge")
                              
                          }
                        }
                    }

                }
            }
}

struct SocialScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SocialScreenView()
    }
}
