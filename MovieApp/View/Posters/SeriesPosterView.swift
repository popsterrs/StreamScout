//
//  SeriesPosterView.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI
import URLImage


struct SeriesPosterView: View {
    var seriesID: Int
    
    @State private var seriesDetails: SeriesDetails?
    
    @State private var showFullPageView: Bool = false
    
    var body: some View {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(seriesDetails?.posterPath ?? "")")!
        
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
                            getSeriesDetails(seriesID: seriesID) { result in
                                switch result {
                                case .success(let details):
                                    seriesDetails = details
                                case .failure(let error):
                                    print("Error: \(error) in movieID: \(seriesID)")
                                }
                            }
                        }
                    
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
                
                Text(seriesDetails?.title ?? String(seriesID))
                    .fontWeight(.light)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .lineLimit(nil)
                    .frame(maxWidth: 125, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: 125)
        .fullScreenCover(isPresented: $showFullPageView) {
            SeriesFullPageView(seriesDetails: seriesDetails!)
        }
    }
    
    func openFullPageView() {
        showFullPageView.toggle()
    }
    
}

struct SeriesPosterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
