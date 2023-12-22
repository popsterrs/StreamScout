//
//  WatchProvider.swift
//  MovieApp
//
//  Created by popsters on 08/04/2023.
//

import SwiftUI

// MARK: - WatchProviderResults
struct WatchProviderResults: Codable {
    let id: Int
    let results: [String: Result]
}

// MARK: - Result
struct Result: Codable {
    let link: String
    let details: [WatchProviderDetails]
}

// MARK: - Flatrate
struct WatchProviderDetails: Codable {
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
