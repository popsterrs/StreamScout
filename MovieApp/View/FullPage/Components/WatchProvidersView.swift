//
//  WatchProvidersView.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

struct WatchProvidersView: View {
    var id: Int
    
    @State private var watchProviders = WatchProviderResults(id: 1, results: ["": WatchProviderResult(link: "", flatrate: [], buy: [])])
    @State private var showProviders: Bool = false
    
    var body: some View {
        VStack {
            if showProviders {
                VStack {
                    Text("Providers")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                        .foregroundColor(.white)
                        .hAlign(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            let country = "GB"
        
                            ForEach(watchProviders.results[country]?.flatrate ?? watchProviders.results[country]?.buy ?? [], id: \.providerID) { flatrate in
                                let imageURL = URL(string: "https://image.tmdb.org/t/p/original\(flatrate.logoPath)")!
                                
                                AsyncImage(url: imageURL) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
        }
        .onAppear() {
            getWatchProviders(id: id) { result in
                switch result {
                case .success(let providers):
                    watchProviders = providers
                    showProviders = true
                    
                    if watchProviders.results.count < 1 {
                        showProviders = false
                    }
                    
                case .failure(let error):
                    showProviders = false
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }

}

struct WatchProvidersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
