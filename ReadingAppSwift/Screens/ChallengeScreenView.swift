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
            }
            Section("Details") {
                Text(challenge.description)
            }
        }.navigationTitle("Challenge Details")
        
    }
}
