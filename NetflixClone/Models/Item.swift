//
//  ItemModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation

struct ApiResponse:Codable {
    
    let page: Int?
    let results: [Item]
}

struct Item: Codable {
    
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}

