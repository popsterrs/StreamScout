//
//  CollectionMovieView.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

struct CollectionMovieView: View {
    var movieDetails: MovieDetails
    
    @State private var showCollection: Bool = false
    @State private var collectionName: String = "Collection"
    @State private var collectionMoviesIds: [Int] = []
    
    var body: some View {
        VStack {
            if showCollection {
                VStack {
                    Text(collectionName)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                        .foregroundColor(.white)
                        .hAlign(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 7) {
                            if (movieDetails.belongsToCollection != nil) {
                                ForEach(collectionMoviesIds, id: \.self) { id in
                                    MoviePosterView(movieID: id)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .onAppear() {
            
            collectionMoviesIds = []
            
            if (movieDetails.belongsToCollection != nil) {
                if let collectionID = movieDetails.belongsToCollection?.id {
                    
                    getCollectionDetails(collectionID: collectionID) { result in
                        switch result {
                        case .success(let details):
                            var array: [Int] = []
                            
                            for movie in details.parts {
                                array.append(movie.id)
                                showCollection = true
                            }
                            
                            collectionName = details.name
                            collectionMoviesIds = array
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

struct CollectionMovieView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
