//
//  CollectionDetails.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

// MARK: - CollectionDetails
struct CollectionDetails: Codable {
    let id: Int
    let name, overview: String
    let posterPath: String?
    let backdropPath: String
    let parts: [Part]

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case parts
    }
}

// MARK: - Part
struct Part: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview, releaseDate: String
    let posterPath: String
    let popularity: Double
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
