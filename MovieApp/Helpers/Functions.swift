//
//  Functions.swift
//  MovieApp
//
//  Created by popsters on 04/04/2023.
//

extension View{
    func closeKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for :nil)
    }
}
