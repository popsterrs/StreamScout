//
//  Favourites.swift
//  MovieApp
//
//  Created by popsters on 05/04/2023.
//

import SwiftUI

struct Favourites: View {
    @AppStorage("favouritedString") var favouritedString: String = ""
    
    @State private var favouritedArray: [Int] = []
    
    let itemWidth: CGFloat = 125 //Found in the movieposterview or the seriesposterview
    let minimumItemSpacing: CGFloat = 7
    let minimumColumnsCount = 3
    
    var body: some View {
        NavigationView() {
            VStack {
                if favouritedArray.count < 1 {
                    VStack {
                        Text("No favourites yet")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        Text("Favourite something with the star \n for it to appear here")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .hAlign(.center)
                    .vAlign(.center)
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        GeometryReader { geometry in
                              let availableWidth = geometry.size.width
                              let columnsCount = max(Int(availableWidth / (itemWidth + minimumItemSpacing)), minimumColumnsCount)
                              
                            LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)), count: columnsCount), spacing: minimumItemSpacing) {
                                ForEach(favouritedArray, id: \.self) { id in
                                    AmbiguousPosterView(id: id)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear() {
                favouritedArray = splitStringIntoArray(string: favouritedString)
            }
            .onChange(of: favouritedString) { newValue in
                favouritedArray = splitStringIntoArray(string: newValue)
            }
            .navigationBarTitle("Favourites")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        Favourites()
    }
}
