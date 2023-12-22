//
//  ContentView.swift
//  MovieApp
//
//  Created by popsters on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            
            TabView {
                Home()
                    .ignoresSafeArea(.container, edges: .top)
                    .tabItem() {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                Search()
                    .tabItem() {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                Movies()
                    .tabItem() {
                        Image(systemName: "film.stack")
                        Text("Movies")
                    }
                Series()
                    .tabItem() {
                        Image(systemName: "tv.fill")
                        Text("Series")
                    }
                Favourites()
                    .tabItem() {
                        Image(systemName: "star.fill")
                        Text("Favourites")
                    }
            }
            .onAppear() {
//                UITabBar.appearance().barTintColor = .black
//                UITabBar.appearance().isTranslucent = false
//                UITabBar.appearance().shadowImage = nil
//
//                let appearance = UITabBarAppearance()
//                appearance.configureWithTransparentBackground()
//                UITabBar.appearance().standardAppearance = appearance
                
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor.black
                UITabBar.appearance().standardAppearance = tabBarAppearance
            }
            .tint(.white)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
