//
//  NavigationBarScreen.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct NavigationBarScreen: View {
    let cacheBase: CacheBase = CacheBase()
    let libraryBase: LibraryBase = LibraryBase()
    let bookLogBase: BookLogBase = BookLogBase()
    
    var body: some View {
        TabView {
            HomeScreenView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchScreenView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            DiscoverScreenView()
                .tabItem {
                    Label("Discover", systemImage: "safari")
                }
            SocialScreenView()
                .tabItem {
                    Label("Social", systemImage: "person.3")
                }
            FirebaseLoginScreen()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .environmentObject(libraryBase)
        .environmentObject(cacheBase)
        .environmentObject(bookLogBase)
        
    }
}

struct NavigationBarScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationBarScreen()
    }
}


