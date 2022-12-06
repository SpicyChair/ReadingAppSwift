//
//  LeaderboardCard.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 06/12/2022.
//

import Foundation
import SwiftUI

struct LeaderboardCard: View {
    
    var username: String
    var count: Int
    var place: Int
    
    var body: some View {
        HStack {
            Text("\(place)")
                .foregroundColor(.gray)
            Text(username)
                .frame(maxWidth: Double.infinity, alignment: .leading)
            Text("\(count)")
                .bold()
        }
    }
}
