//
//  ChallengeScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 30/11/2022.
//

import SwiftUI

struct ChallengeScreenView: View {
    
    var challenge: Challenge
    
    var body: some View {
        Form {
            Section {
                Text(challenge.title)
                Text(challenge.createdBy)
            }
            
            Section("Details") {
                Text(challenge.description)
            }
        }.navigationTitle("Challenge Details")
        
    }
}
