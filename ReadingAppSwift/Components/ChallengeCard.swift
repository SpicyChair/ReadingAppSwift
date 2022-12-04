//
//  ChallengeTile.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 30/11/2022.
//

import SwiftUI

struct ChallengeCard: View {
    
    var challenge: Challenge
    @EnvironmentObject var adapter: FirestoreAdapter
    
    var body: some View {
        NavigationLink(destination: ChallengeScreenView(challenge: challenge)) {
            VStack (alignment: .leading){
            Text(challenge.title)
                .font(.system(size: 19, weight: .bold, design: .serif))
            // get the username from the adapter dictionary
                Text("By \(adapter.users[challenge.createdBy]?.name ?? "Anonymous")")
                .font(.system(size: 15, weight: .regular, design: .serif))
            }
        }
    }
}


