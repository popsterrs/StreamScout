//
//  SeriesPlayView.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//


import SwiftUI
import URLImage

struct SeriesPlayView: View {
    var seriesDetails: SeriesDetails
    
    @State private var titleHeight: CGFloat = .zero
    
    var body: some View {
            
        Artwork(details: .series(seriesDetails))
        
        GeometryReader {proxy in
            VStack {
                Text(seriesDetails.title)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                    .padding(.vertical, -45)
                    .padding(.horizontal, 15)
                    .lineLimit(1)
                    .hAlign(.leading)

                
//                HStack {
//                    Text("\(seriesDetails.numberOfSeasons) Seasons")
//                        .foregroundColor(.gray)
//                        .padding(.vertical, -20)
//                        .padding(.horizontal, 15)
//                        .hAlign(.leading)
//
//                    Text(seriesDetails.originalLanguage)
//                        .textCase(.uppercase)
//                        .foregroundColor(.gray)
//                        .padding(.vertical, -20)
//                        .padding(.horizontal, 15)
//                        .hAlign(.trailing)
//                }
                
                HStack {
                    HStack {
                        HStack {
                            Text(stringDateToYear(string: seriesDetails.lastAirDate))
                            Text("\(seriesDetails.numberOfSeasons) Seasons")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 15)
                                .fixedSize()
                                .hAlign(.leading)
                            Text("\(seriesDetails.voteAverage!, specifier: "%.1f")")
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 13, height: 13)
                                .padding(.horizontal, -6)
                        }
                        .foregroundColor(.gray)
                        .padding(.horizontal, 15)
                        .hAlign(.leading)
                        
                        HStack {
                            Text(seriesDetails.originalLanguage)
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
                    .padding(.vertical, -5)
                }
            }
        }
        .frame(height: 50)
        
    }
    
}

struct SeriesPlayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
