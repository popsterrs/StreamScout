//
//  GenreView.swift
//  MovieApp
//
//  Created by popsters on 03/04/2023.
//

import SwiftUI

struct GenreView: View {
    var genre: String
    var genreID: Int
    var type: String
    
    @State private var movieIDs: [Int] = []
    @State private var seriesIDs: [Int] = []
    
    var body: some View {
        VStack {
            Text(genre)
                .fontWeight(.semibold)
                .padding(.horizontal, 10)
                .foregroundColor(.gray)
                .hAlign(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 7) {
                    if type == "Both" {
                        let combinedArray = movieIDs + seriesIDs

                        ForEach(combinedArray.shuffled(), id: \.self) { id in
                            AmbiguousPosterView(id: id)
                        }
                    } else if type == "Movies" {
                        ForEach(movieIDs, id: \.self) { movieId in
                            MoviePosterView(movieID: movieId)
                        }
                    } else if type == "Series" {
                        ForEach(seriesIDs, id: \.self) { seriesId in
                            SeriesPosterView(seriesID: seriesId)
                        }
                    }
                }
            }

        }
        .onAppear() {
            getMovieIdsByGenre(genreId: genreID) { result in
                switch result {
                case .success(let movieIds):
                    movieIDs = movieIds
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            getSeriesIdsByGenre(genreId: genreID) { result in
                switch result {
                case .success(let seriesIds):
                    seriesIDs = seriesIds
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
