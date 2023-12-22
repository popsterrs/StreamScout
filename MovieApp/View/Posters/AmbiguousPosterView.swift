//
//  AmbiguousPosterView.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI

struct AmbiguousPosterView: View {
    var id: Int
    
    @State private var mediaType = "unknown"
    
    var body: some View {
        VStack {
            if mediaType == "movie" {
                MoviePosterView(movieID: id)
            } else if mediaType == "series" {
                SeriesPosterView(seriesID: id)
            } else {
                EmptyView()
            }
        }
        .onAppear() {
            getMediaType(id: id) { type in
                switch type {
                case .movie:
                    mediaType = "movie"
                case .tvSeries:
                    mediaType = "series"
                case .unknown:
                    mediaType = "unknown"
                }
            }
        }
    }
}

struct AmbiguousPosterView_Previews: PreviewProvider {
    static var previews: some View {
        AmbiguousPosterView(id: 456)
    }
}
