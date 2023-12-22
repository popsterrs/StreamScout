//
//  Series.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI

struct Series: View {
    var body: some View {
        NavigationView() {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    GenreView(genre: "Comedy", genreID: 35, type: "Series")
                    GenreView(genre: "Animation", genreID: 16, type: "Series")
                }
            }
            .coordinateSpace(name: "SCROLL")
            .navigationBarTitle("Series")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Series_Previews: PreviewProvider {
    static var previews: some View {
        Series()
    }
}
