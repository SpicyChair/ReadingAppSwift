//
//  ChallengeScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 30/11/2022.
//

import SwiftUI

struct ChallengeScreenView: View {
    
    var challenge: Challenge
    @EnvironmentObject var adapter: FirestoreAdapter
    
    var body: some View {
        Form {
            Section {
                Text(challenge.title)
                    .font(.system(size: 25, weight: .bold, design: .serif))
                Text("By \(adapter.users[challenge.createdBy]?.name ?? "Anonymous")")
                    .font(.system(size: 17, weight: .regular, design: .serif))
                
                Button ("Join / Leave Challenge") {
                    adapter.toggleUserInChallenge(uid: challenge.uid)
                }
            }
            
            Section("Participants") {
                if (adapter.currentChallengeParticipants.isEmpty) {
                    Text("Be the first to join this challenge!")
                } else {
                    // the id is the index 1 of the (index, userID) array
                    // ie the string
                    
                    // enumerated returns an indexed version
                    ForEach(Array(adapter.currentChallengeParticipants.enumerated()), id: \.1.self) { (index, user) in
                        NavigationLink(destination: UserScreenView(user: user)) {
                            LeaderboardCard(username: user.name, count: user.pageProgress, place: index + 1)
                        }
                    }

                }
            }
            Section("Details") {
                Text(challenge.description)
            }
        }
        .onAppear {
            adapter.getChallengeParticipants(uid: challenge.uid)
        }
        .navigationTitle("Challenge Details")
        
    }
}
