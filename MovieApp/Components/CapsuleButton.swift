//
//  CapsuleButton.swift
//  MovieApp
//
//  Created by popsters on 02/04/2023.
//

import SwiftUI

struct CapsuleButton: View {
    let label: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .cornerRadius(15)
        }
    }
}
