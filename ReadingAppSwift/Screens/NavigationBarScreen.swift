//
//  NavigationBarScreen.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct NavigationBarScreen: View {
    var body: some View {
        TabView {
            SearchScreenView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchScreenView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SearchScreenView()
                .tabItem {
                    Label("Library", systemImage: "book")
                }
            SearchScreenView()
                .tabItem {
                    Label("Social", systemImage: "mount")
                }
        }
    }
}

struct NavigationBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarScreen()
    }
}


