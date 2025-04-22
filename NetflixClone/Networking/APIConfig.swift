//
//  Url.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 19/04/23.
//

import Foundation

struct APIConfig {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let API_KEY = "00d626f8a69df5cc36ec9689858d16b6"
}

enum Endpoint {
    case genreMovieList
    case discoverMovie
    case discoverTV
    case moviePopular
    case tvPopular
    case trendingMoviesDay
    case trendingTVsDay
    case search(type: String)
    case movieVideos(id: Int)
    case movieDetail(id: Int)
    case tvDetail(id: Int)
    
    var fullPath: String {
        return APIConfig.baseUrl + path
    }
    
    var path: String {
        switch self {
        case .genreMovieList:
            return "/genre/movie/list"
            
        case .discoverMovie:
            return "/discover/movie"
            
        case .discoverTV:
            return "/discover/tv"
            
        case .moviePopular:
            return "/movie/popular"
            
        case .tvPopular:
            return "/tv/popular"
            
        case .trendingMoviesDay:
            return "/trending/movie/day"
            
        case .trendingTVsDay:
            return "/trending/tv/day"
            
        case .search(let type):
            return "/search/\(type)"
            
        case .movieVideos(let id):
            return "/movie/\(id)/videos"
            
        case .movieDetail(let id):
            return "/movie/\(id)"
            
        case .tvDetail(let id):
            return "/tv/\(id)"
        }
    }
}
