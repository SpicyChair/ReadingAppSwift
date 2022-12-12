//
//  UserScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 10/12/2022.
//

import SwiftUI

struct UserScreenView: View {
    
    var user: User
    
    var body: some View {
        Form {
            Section {
                Text(user.name)
                    .font(.system(size: 25, weight: .bold, design: .serif))
                Text(user.uid)
                    .font(.system(size: 15, weight: .regular, design: .serif))
            }
            
            

            Section("Details") {
                Text("\(user.pageProgress)")
            }
        }
        .navigationTitle("User Details")
    }
}

