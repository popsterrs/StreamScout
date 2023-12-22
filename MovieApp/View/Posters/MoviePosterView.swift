//
//  PosterView.swift
//  MovieApp
//
//  Created by popsters on 03/04/2023.
//

import SwiftUI
import URLImage


struct MoviePosterView: View {
    var movieID: Int
    
    @State private var movieDetails: MovieDetails?
    
    @State private var showFullPageView: Bool = false
    
    var body: some View {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movieDetails?.posterPath ?? "")")!
        
        Button {
            openFullPageView()
        } label: {
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.black)
                        .frame(width: 125, height: 190)
                        .cornerRadius(10)
                        .onAppear() {
                            getMovieDetails(movieID: movieID) { result in
                                switch result {
                                case .success(let details):
                                    movieDetails = details
                                case .failure(let error):
                                    print("Error: \(error) in movieID: \(movieID)")
                                }
                            }
                        }
                    
//                    URLImage(imageURL) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 125, height: 190)
//                            .cornerRadius(10)
//                            .clipped()
//                    }
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 125, height: 190)
                            .cornerRadius(10)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(movieDetails?.title ?? String(movieID))
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .frame(maxWidth: 125, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: 125)
        .fullScreenCover(isPresented: $showFullPageView) {
            MovieFullPageView(movieDetails: movieDetails!)
        }
    }
    
    func openFullPageView() {
        showFullPageView.toggle()
    }
    
}

struct MoviePoster_ViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
