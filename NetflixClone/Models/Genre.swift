//
//  Genre.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 14/04/23.
//

import Foundation

struct GenreApiResponse: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String?
}
