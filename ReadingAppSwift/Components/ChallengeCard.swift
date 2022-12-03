//
//  ChallengeTile.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 30/11/2022.
//

import SwiftUI

struct ChallengeCard: View {
    
    var challenge: Challenge
    
    var body: some View {
        NavigationLink(destination: ChallengeScreenView(challenge: challenge)) {
            VStack (alignment: .leading){
            Text(challenge.title)
                .font(.system(size: 19, weight: .bold, design: .serif))
            //Text(challenge.description)
            Text("By \(challenge.createdBy)")
                .font(.system(size: 15, weight: .regular, design: .serif))
            }
        }
    }
}


