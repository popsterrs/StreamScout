//
//  MoviePlayView.swift
//  MovieApp
//
//  Created by popsters on 04/04/2023.
//

import SwiftUI
import URLImage

struct MoviePlayView: View {
    var movieDetails: MovieDetails
    
    @State private var titleHeight: CGFloat = .zero
    
    var body: some View {
        
        Artwork(details: .movie(movieDetails))
        
        VStack {
            Text(movieDetails.title)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.system(size: 25))
                .padding(.vertical, -45)
                .padding(.horizontal, 15)
                .lineLimit(1)
                .hAlign(.leading)
            
            
            HStack {
                let (hours, minutes) = minutesToHoursAndMinutes(int: movieDetails.runtime)
                
                HStack {
                    HStack {
                        Text(stringDateToYear(string: movieDetails.releaseDate))
                        Text("\(hours)h \(minutes)m")
                        Text("\(movieDetails.voteAverage, specifier: "%.1f")")
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .padding(.horizontal, -6)
                    }
                    .foregroundColor(.gray)
                    .padding(.horizontal, 15)
                    .hAlign(.leading)
                    
                    HStack {
                        Text(movieDetails.originalLanguage)
                            .textCase(.uppercase)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 15)
                            .hAlign(.trailing)
                    }
                }
            }
            
            VStack {
                Button {
                    
                } label: {
                    (Text(Image(systemName: "play.fill")) + Text("  ") + Text("Play"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background {
                            Rectangle()
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 15)
            }
        }
        //        .frame(height: 50)
        
    }
}
    
struct MoviePlayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
