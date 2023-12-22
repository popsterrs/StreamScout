//
//  Search.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

struct Search: View {
    @State private var searchText: String = ""
    @State private var searchResults = SearchResultDetails(page: 0, results: [], totalPages: 0, totalResults: 0)
    
    let itemWidth: CGFloat = 125 //Found in the movieposterview or the seriesposterview
    let minimumItemSpacing: CGFloat = 7
    let minimumColumnsCount = 3

    var body: some View {
        NavigationView {
            let resultIds = searchResults.results.map { $0.id }
            
            ScrollView(.vertical, showsIndicators: false) {
        
                GeometryReader { geometry in
                      let availableWidth = geometry.size.width
                      let columnsCount = max(Int(availableWidth / (itemWidth + minimumItemSpacing)), minimumColumnsCount)
                      
                      LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)), count: columnsCount), spacing: minimumItemSpacing) {
                            ForEach(resultIds, id: \.self) { id in
                                AmbiguousPosterView(id: id)
                            }
                            if searchResults.page < searchResults.totalPages {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .onAppear {
                                        searchMoviesAndSeries(query: searchText, page: searchResults.page + 1) { result in
                                            switch result {
                                            case .success(let searchData):
                                                searchResults.results.append(contentsOf: searchData.results)
                                                searchResults.page = searchData.page
                                                searchResults.totalPages = searchData.totalPages
                                                searchResults.totalResults = searchData.totalResults
                                            case .failure(let error):
                                                print("Error: \(error.localizedDescription)")
                                            }
                                        }
                                    }
                            }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
            .onSubmit(of: .search, {
                searchMoviesAndSeries(query: searchText, page: 1) { result in
                    switch result {
                    case .success(let searchData):
                        searchResults = searchData
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })
            .onChange(of: searchText, perform: {newValue in
                if newValue.isEmpty {
                    searchResults = SearchResultDetails(page: 0, results: [], totalPages: 0, totalResults: 0)
                }
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private var gridColumns: [GridItem] {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return Array(repeating: .init(.flexible(minimum: 0, maximum: .infinity), spacing: 0), count: 6)
        }
        #endif
        
        // Default to 3 columns for iPhones and any other devices
        return Array(repeating: .init(.flexible(minimum: 0, maximum: .infinity), spacing: 0), count: 3)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
