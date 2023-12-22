//
//  EpisodesView.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI
import URLImage

struct EpisodesView: View {
    var seriesDetails: SeriesDetails
    
    @State private var selectedSeason = 0
    @State private var seasonDetails: SeasonDetails = SeasonDetails(id: "", airDate: "", episodes: [], name: "unititled", overview: "", seasonDetailsID: 0, posterPath: "", seasonNumber: 0)
    
    var body: some View {
        VStack {
            Divider()
                .background(Color.gray)
                .padding(.horizontal, 5)
                .opacity(0.5)
            
            Picker("Season", selection: $selectedSeason) {
                ForEach(seriesDetails.seasons!.indices, id: \.self) { index in
                    Text(self.seriesDetails.seasons![index].title)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal, 15)
            .padding(.vertical, -10)
            .vAlign(.leading)
            .onChange(of: selectedSeason) { newValue in
                getSeasonDetails(seriesID: seriesDetails.id, seasonNumber: selectedSeason) { result in
                    switch result {
                    case .success(let details):
                        seasonDetails = details
                    case .failure(let error):
                        print("Error: \(error) in movieID: \(seriesDetails.id)")
                    }
                }
            }
            
            Divider()
                .background(Color.gray)
                .padding(.horizontal, 5)
                .opacity(0.5)
            
            VStack(spacing: 3) {
                ForEach(seasonDetails.episodes, id: \.self) { episode in
                    Button {
                        playEpisode(episode: episode)
                    } label: {
                        
                        HStack {
                            VStack {
                                let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(episode.stillPath ?? "")")!
                                
                                VStack {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(.black)
                                            .frame(width: 130, height: 90)
                                            .cornerRadius(10)
                                        
                                        URLImage(imageURL) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .cornerRadius(10)
                                                .frame(width: 130, height: 90)
                                                .clipped()
                                        }
                                        
                                        Image(systemName: "play.fill")
                                            .opacity(0.5)
                                            .scaleEffect(1.8)
                                    }
                                }
                                .frame(maxWidth: 125)
                            }
                            .padding(.horizontal, 15)
                            .hAlign(.leading)
                            
                            
                            Text(episode.title)
                                .font(.callout)
                                .fontWeight(.semibold)
                                .hAlign(.leading)
                                .vAlign(.leading)

                        }
                        .frame(height: 100)
                        .frame(maxHeight: 100)
                        
    //                    Text(episode.overview)
    //                        .font(.caption2)
    //                        .foregroundColor(.gray)
                    }
                    Divider()
                        .background(Color.gray)
                        .padding(.horizontal, 5)
                }
            }
        }
        .onAppear {
            selectedSeason = 0
            
            getSeasonDetails(seriesID: seriesDetails.id, seasonNumber: selectedSeason) { result in
                switch result {
                case .success(let details):
                    seasonDetails = details
                case .failure(let error):
                    print("Error: \(error) in movieID: \(seriesDetails.id)")
                }
            }
        }
    }
    
    func playEpisode(episode: Episode) {
        print("Play \(episode.title) from \(seriesDetails.title)")
    }
}


struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
