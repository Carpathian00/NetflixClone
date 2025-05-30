//
//  ItemModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation

struct ApiResponse: Codable, MediaResponseProtocol {
    let page: Int?
    var results: [ItemData]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ItemData: Codable {
    let id: Int?
    let originalTitle: String?
    let originalName: String?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
        
    enum CodingKeys: String ,CodingKey {
        case id
        case originalTitle = "original_title"
        case originalName = "original_name"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

