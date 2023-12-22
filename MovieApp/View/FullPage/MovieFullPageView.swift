//
//  MovieFullPageView.swift
//  MovieApp
//
//  Created by popsters on 04/04/2023.
//

import SwiftUI

struct MovieFullPageView: View {
    var movieDetails: MovieDetails
    
    @State private var isFavourited: Bool = false
    
    @AppStorage("favouritedString") var favouritedString: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    MoviePlayView(movieDetails: movieDetails)
                    
                    Text(movieDetails.overview)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                        .foregroundColor(.gray)
                        .font(.callout)
                    
                    WatchProvidersView(id: movieDetails.id)
                    
                    CollectionMovieView(movieDetails: movieDetails)
                    
                    SimilarMoviesView(movieDetails: movieDetails)
                }
            }
            .overlay(alignment: .topTrailing){
                Button(action: close) {
                    Image(systemName: "arrowshape.backward.fill")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                }
                .padding(.vertical, 10)
                .hAlign(.leading)
                
                Button(action: favourite) {
                    Image(systemName: isFavourited ? "star.fill" : "star")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 6)
                }
                .padding(.vertical, 10)
                .hAlign(.trailing)
                .onAppear() {
                    let favouritedArray = splitStringIntoArray(string: favouritedString)
                    
                    if let _ = favouritedArray.firstIndex(of: movieDetails.id) {
                        isFavourited = true
                    } else {
                        isFavourited = false
                    }
                }
            }
        }
        .vAlign(.leading)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 0 {
                        close()
                    }
                }
        )
    }
    
    
    func close() {
        dismiss()
    }
    
    func favourite() {
        var favouritedArray = splitStringIntoArray(string: favouritedString)
        
        if let index = favouritedArray.firstIndex(of: movieDetails.id) {
            // MARK: - Remove from favourites list
            favouritedArray.remove(at: index)
            let numbersString = favouritedArray.map { String($0) }.joined(separator: "-")
            favouritedString = numbersString
            isFavourited = false
        } else {
            // MARK: - Add to favouites list
            favouritedArray.append(movieDetails.id)
            let numbersString = favouritedArray.map { String($0) }.joined(separator: "-")
            favouritedString = numbersString
            isFavourited = true
        }

    }
}

struct MovieFullPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
