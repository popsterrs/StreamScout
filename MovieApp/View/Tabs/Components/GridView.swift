//
//  GridView.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

struct GridView: View {
    @State var array: [Int] = []
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [
                GridItem(.flexible(minimum: 0, maximum: .infinity), spacing: 0),
                GridItem(.fixed(UIScreen.main.bounds.width / 3), spacing: 0),
                GridItem(.fixed(UIScreen.main.bounds.width / 3), spacing: 0),
            ], spacing: 0) {
                ForEach(array, id: \.self) { id in
                    AmbiguousPosterView(id: id)
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
