//
//  SocialScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SocialScreenView: View {
    
    @EnvironmentObject var adapter: FirestoreAdapter
    @State private var showingSheet = false
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                if !adapter.challenges.isEmpty {
                    List {
                        ForEach(adapter.challenges, id: \.self) { challenge in
                            
                            ChallengeCard(challenge: challenge)
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
                adapter.getUsers()
                adapter.getChallenges()
            }
            .toolbar {
                Button("Add") {
                    self.showingSheet = true
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
