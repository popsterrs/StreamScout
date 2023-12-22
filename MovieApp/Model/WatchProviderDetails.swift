//
//  WatchProviderDetails.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

// MARK: - WatchProviderResults
struct WatchProviderResults: Codable {
    let id: Int
    let results: [String: WatchProviderResult]
}

// MARK: - Result
struct WatchProviderResult: Codable {
    let link: String
    let flatrate: [Flatrate]?
    let buy: [Flatrate]?
}

// MARK: - Flatrate
struct Flatrate: Codable {
    let logoPath: String
    let providerID: Int
    let providerName: String
    let displayPriority: Int

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}
