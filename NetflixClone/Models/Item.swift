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
    let totalPages: Int?
    let totalResults: Int?

    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

struct Item: Codable {
    
    let id: Int?
    let originalTitle: String?
    let originalName: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    var releaseYear: String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           if let date = dateFormatter.date(from: releaseDate ?? "") {
               dateFormatter.dateFormat = "yyyy"
               return dateFormatter.string(from: date)
           }
           return nil
       }
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case originalName = "original_name"
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

