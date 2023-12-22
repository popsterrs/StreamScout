//
//  SearchResultDetails.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let searchResultDetails = try? JSONDecoder().decode(SearchResultDetails.self, from: jsonData)

import Foundation

// MARK: - SearchResultDetails
struct SearchResultDetails: Codable {
    var page: Int
    var results: [SearchResult]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResult: Codable {
//    let adult: Bool
//    let backdropPath: String?
    let id: Int
//    let name: String?
//    let originalLanguage: OriginalLanguage?
//    let originalName, overview, posterPath: String?
//    let mediaType: MediaType
//    let genreIDS: [Int]?
//    let popularity: Double?
//    let firstAirDate: String?
//    let voteAverage: Double?
//    let voteCount: Int?
//    let originCountry: [String]?
//    let title, originalTitle, releaseDate: String?
//    let video: Bool?
//    let gender: Int?
//    let knownForDepartment: String?
//    let profilePath: String?
//    let knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
        case id
//        case name
//        case originalLanguage = "original_language"
//        case originalName = "original_name"
//        case overview
//        case posterPath = "poster_path"
//        case mediaType = "media_type"
//        case genreIDS = "genre_ids"
//        case popularity
//        case firstAirDate = "first_air_date"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//        case originCountry = "origin_country"
//        case title
//        case originalTitle = "original_title"
//        case releaseDate = "release_date"
//        case video, gender
//        case knownForDepartment = "known_for_department"
//        case profilePath = "profile_path"
//        case knownFor = "known_for"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}
