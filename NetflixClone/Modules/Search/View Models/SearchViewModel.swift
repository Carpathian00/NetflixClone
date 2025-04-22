//
//  SearchViewModels.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 03/05/23.
//

import Foundation

class SearchViewModel {
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindTrendingMoviesData: (([ItemData]?) -> ())?
    var bindTrendingTVsData: (([ItemData]?) -> ())?
    var bindMovieSearchResultData: (([ItemData]?) -> ())?
    var bindTvShowsSearchResultData: (([ItemData]?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    func fetchTrendingMoviesData() {
        let url = Endpoint.trendingMoviesDay.fullPath
        let params = ["api_key": APIConfig.API_KEY]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let trendingMovies = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self?.bindTrendingMoviesData?(trendingMovies.results)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTrendingTvsData() {
        let url = Endpoint.trendingTVsDay.fullPath
        let params = ["api_key": APIConfig.API_KEY]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let trendingTVs = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self?.bindTrendingTVsData?(trendingTVs.results)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSearchData(query: String?, type: String) {
        guard let query = query else { return }
        
        let url = Endpoint.search(type: type).fullPath
        let params = [
            "api_key": APIConfig.API_KEY,
            "query": query
        ]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let searchResults = try? JSONDecoder().decode(ApiResponse.self, from: data) {
                    DispatchQueue.main.async {
                        if type == SearchRequestType.movie.rawValue {
                            self?.bindMovieSearchResultData?(searchResults.results)
                        } else {
                            self?.bindTvShowsSearchResultData?(searchResults.results)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
