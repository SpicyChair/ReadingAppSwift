//
//  DiscoverScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct DiscoverScreenView: View {
    var body: some View {
        NavigationView {
            Form {
                Text("Hello World")
            }.navigationTitle("Discover")
        }
        .navigationViewStyle(.stack)
    }
}

struct DiscoverScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverScreenView()
    }
}
