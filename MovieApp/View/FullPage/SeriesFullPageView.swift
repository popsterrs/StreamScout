//
//  SeriesFullPageView.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI

struct SeriesFullPageView: View {
    var seriesDetails: SeriesDetails
    
    @State private var isFavourited: Bool = false
    
    @AppStorage("favouritedString") var favouritedString: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack() {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    SeriesPlayView(seriesDetails: seriesDetails)
                    
                    Text(seriesDetails.overview)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 15)
                        .foregroundColor(.gray)
                        .font(.callout)
                    
                    WatchProvidersView(id: seriesDetails.id)
                    
                    EpisodesView(seriesDetails: seriesDetails)
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

                    if let _ = favouritedArray.firstIndex(of: seriesDetails.id) {
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
        
        if let index = favouritedArray.firstIndex(of: seriesDetails.id) {
            // MARK: - Remove from favourites list
            favouritedArray.remove(at: index)
            let numbersString = favouritedArray.map { String($0) }.joined(separator: "-")
            favouritedString = numbersString
            isFavourited = false
        } else {
            // MARK: - Add to favouites list
            favouritedArray.append(seriesDetails.id)
            let numbersString = favouritedArray.map { String($0) }.joined(separator: "-")
            favouritedString = numbersString
            isFavourited = true
        }

    }
}

struct SeriesFullPageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
