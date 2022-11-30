//
//  SocialScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SocialScreenView: View {
    
    @EnvironmentObject var adapter: FirestoreAdapter
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(adapter.challenges, id: \.self) { challenge in
                        
                        VStack (alignment: .leading){
                            Text(challenge.title)
                            Text(challenge.description)
                            Text(challenge.createdBy)
                        }
                    }
                    
                }.onAppear(perform: adapter.getChallenges)
                Button(action: {
                    adapter.getChallenges()
                 }) {
                    Text("Get Challenge")
                }
                Button(action: {
                    adapter.createChallenge(title: "Book Challenge", description: "Read read read read!!")
                 }) {
                    Text("Create Challenge")
                }
            }.navigationTitle("Social")
        }
        .navigationViewStyle(.stack)
    }
}

struct SocialScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SocialScreenView()
    }
}
