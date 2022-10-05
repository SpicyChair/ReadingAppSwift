//
//  SocialScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct SocialScreenView: View {
    var body: some View {
        NavigationView {
            Form {
                Text("Hello World")
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
