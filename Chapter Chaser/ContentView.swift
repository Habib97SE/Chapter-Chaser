//
//  ContentView.swift
//  Chapter Chaser
//
//  Created by Habib Hezarehee on 2024-02-28.
//


import SwiftUI
import SwiftData


struct ContentView: View {
    @AppStorage("isFirstTime") var isFirstTime = true
    
    var body: some View {
        Group {
            if isFirstTime {
                RegisterView(isFirstTime: $isFirstTime)
            } else {
                tabView
            }
        }
    }
    
    var tabView: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "globe")
                }
            FavoriteView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .toolbarBackground(.indigo, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
    }
}



#Preview {
    ContentView()
}
