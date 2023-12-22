//
//  SimilarMoviesView.swift
//  MovieApp
//
//  Created by popsters on 04/04/2023.
//

import SwiftUI

struct SimilarMoviesView: View {
    var movieDetails: MovieDetails
    
    @State private var similarMovies = SimilarMovies(page: 0, results: [], totalPages: 0, totalResults: 0)
    @State private var showSimilar: Bool = true
    
    var body: some View {
        VStack {
            if showSimilar {
                VStack {
                    Text("Similar Movies")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                        .foregroundColor(.white)
                        .hAlign(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 7) {                            
                            ForEach(similarMovies.results, id: \.self) { movie in
                                MoviePosterView(movieID: movie.id)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .onAppear() {
            getSimilarMovies(movieID: movieDetails.id) { result in
                switch result {
                case .success(let similar):
                    similarMovies = similar
                    showSimilar = true                    
                case .failure(let error):
                    showSimilar = false
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
struct SimilarMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
