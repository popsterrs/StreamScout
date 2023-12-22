//
//  LoopingScrollView.swift
//  MovieApp
//
//  Created by popsters on 04/04/2023.
//

import SwiftUI

struct LoopingScrollView<Content: View>: View {
    let content: () -> Content
    let itemCount: Int
    let itemWidth: CGFloat
    let itemSpacing: CGFloat
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { scrollView in
                    HStack(spacing: itemSpacing) {
                        ForEach(0..<itemCount) { index in
                            content()
                                .frame(width: itemWidth)
                                .id(index)
                        }
                    }
                    .onChange(of: currentIndex) { index in
                        scrollView.scrollTo(index, anchor: .center)
                    }
                    .frame(width: CGFloat(itemCount) * (itemWidth + itemSpacing), alignment: .leading)
                    .onAppear {
                        scrollView.scrollTo(currentIndex, anchor: .center)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        scrollView.scrollTo(currentIndex, anchor: .center)
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        scrollView.scrollTo(currentIndex, anchor: .center)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .content.offset(x: CGFloat(currentIndex) * (itemWidth + itemSpacing))
            .content.offset(x: -itemSpacing / 2) // Adjust for itemSpacing
            .content.offset(x: -itemWidth / 2) // Adjust for itemWidth
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let delta = value.translation.width
                        let newIndex = max(0, min(currentIndex + Int(-delta / (itemWidth + itemSpacing)), itemCount - 1))
                        if newIndex != currentIndex {
                            currentIndex = newIndex
                        }
                    }
                    .onEnded { value in
                        let delta = value.translation.width
                        let newIndex = max(0, min(currentIndex + Int(-delta / (itemWidth + itemSpacing)), itemCount - 1))
                        if newIndex != currentIndex {
                            currentIndex = newIndex
                        }
                    }
            )
        }
    }
}
