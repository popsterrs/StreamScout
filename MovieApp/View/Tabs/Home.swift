//
//  Home.swift
//  MovieApp
//
//  Created by popsters on 02/04/2023.
//

import SwiftUI

let apiKey = "950d56e041ff3cc769656b1dc9e26606"
let featuredMovieID = 157336

struct Home: View {
    
    @State private var showFullPageView: Bool = false
    
    @State private var featuredMovieDetails = MovieDetails(
        adult: false,
        backdropPath: "default",
        belongsToCollection: Collection(id: 0, name: "nil", posterPath: "", backdropPath: ""),
        budget: 0,
        genres: [],
        homepage: "",
        id: 0,
        originalLanguage: "",
        originalTitle: "",
        overview: "",
        popularity: 0.0,
        posterPath: "",
        releaseDate: "",
        revenue: 0,
        runtime: 0,
        spokenLanguages: [],
        status: "",
        tagline: "",
        title: "",
        video: false,
        voteAverage: 0.0,
        voteCount: 0
    )

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Button {
                    openFullPageView()
                } label: {
                    VStack{
                        MoviePlayView(movieDetails: featuredMovieDetails)
                    }
                }
                
                VStack {
                    GenreView(genre: "Action", genreID: 28, type: "Both")
                    GenreView(genre: "Comedy", genreID: 35, type: "Both")
                    GenreView(genre: "Adventure", genreID: 12, type: "Both")
                    GenreView(genre: "Animation", genreID: 16, type: "Both")
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .onAppear() {
            getMovieDetails(movieID: featuredMovieID) { result in
                switch result {
                case .success(let details):
                    featuredMovieDetails = details
                case .failure(let error):
                    print("Error: \(error) in movieID: \(featuredMovieID)")
                }
            }
        }
        .fullScreenCover(isPresented: $showFullPageView) {
            MovieFullPageView(movieDetails: featuredMovieDetails)
        }
    }
    
    func openFullPageView() {
        showFullPageView.toggle()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
