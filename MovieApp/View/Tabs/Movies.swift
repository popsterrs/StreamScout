//
//  Movies.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI

struct Movies: View {
    var body: some View {
        NavigationView() {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    GenreView(genre: "Action", genreID: 28, type: "Movies")
                    GenreView(genre: "Comedy", genreID: 35, type: "Movies")
                    GenreView(genre: "Adventure", genreID: 12, type: "Movies")
                    GenreView(genre: "Animation", genreID: 16, type: "Movies")
                }
            }
            .coordinateSpace(name: "SCROLL")
            .navigationBarTitle("Movies")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
