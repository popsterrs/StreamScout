//
//  Artwork.swift
//  MovieApp
//
//  Created by popsters on 13/08/2023.
//

import SwiftUI

enum MediaDetails {
    case movie(MovieDetails)
    case series(SeriesDetails)
}


struct Artwork: View {
    var details: MediaDetails
    
    var body: some View {
        let size = UIScreen.main.bounds.size
        let height = size.height * 0.3

        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = (minY / (height * 0.8)) - 0.10
            
            switch details {
            case .movie(let movieDetails):
                let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(movieDetails.backdropPath ?? "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg")")!
                
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                        .overlay(content: {
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(
                                        .linearGradient(colors: [
                                            .black.opacity(0 - progress),
                                            .black.opacity(0.1 - progress),
                                            .black.opacity(0.3 - progress),
                                            .black.opacity(0.5 - progress),
                                            .black.opacity(0.8 - (progress / 2)),
                                            .black.opacity(1),
                                        ], startPoint: .top, endPoint: .bottom)
                                    )
                            }
                        })
                        .offset(y: (-minY))
                } placeholder: {
                    ProgressView()
                }
                .mask(Rectangle().edgesIgnoringSafeArea(.top))

            case .series(let seriesDetails):
                let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(seriesDetails.backdropPath ?? "/hZkgoQYus5vegHoetLkCJzb17zJ.jpg")")!
                
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                        .overlay(content: {
                            ZStack(alignment: .bottom) {
                                Rectangle()
                                    .fill(
                                        .linearGradient(colors: [
                                            .black.opacity(0 - progress),
                                            .black.opacity(0.1 - progress),
                                            .black.opacity(0.3 - progress),
                                            .black.opacity(0.5 - progress),
                                            .black.opacity(0.8 - (progress / 2)),
                                            .black.opacity(1),
                                        ], startPoint: .top, endPoint: .bottom)
                                    )
                            }
                        })
                        .offset(y: -minY)
                } placeholder: {
                    ProgressView()
                }
                .mask(Rectangle().edgesIgnoringSafeArea(.top))

            }
            
        }
        .frame(height: height + getSafeAreaTop())
        .scaledToFill()
    }
}
