//
//  SearchViewModels.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 03/05/23.
//

import Foundation

class SearchViewModel {
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindTrendingMoviesData: (([Item]?) -> ())?
    var bindTrendingTVsData: (([Item]?) -> ())?
    var bindMovieSearchResultData: (([Item]?) -> ())?
    var bindTvShowsSearchResultData: (([Item]?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    func fetchTrendingMoviesData() {
        let url = APIConfig.baseUrl + "/trending/movie/day" + "?api_key=\(APIConfig.API_KEY)"
        
        self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
            switch result {
            case .success(let trendingMovies):
                self.bindTrendingMoviesData?(trendingMovies.results)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        })
    }
    
    func fetchTrendingTvsData() {
        let url = APIConfig.baseUrl + "/trending/tv/day" + "?api_key=\(APIConfig.API_KEY)"
        
        self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
            switch result {
            case .success(let trendingTVs):
                self.bindTrendingTVsData?(trendingTVs.results)
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        })
    }
    
    func fetchSearchData(query: String?, type: String) {
        guard let query = query else { return }
        
        let url = APIConfig.baseUrl + "/search/\(type)" + "?api_key=\(APIConfig.API_KEY)" + "&query=\(query)"
        
        self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
            switch result {
            case .success(let itemResult):
                if type == SearchRequestType.movie.rawValue {
                    self.bindMovieSearchResultData?(itemResult.results)
                } else {
                    self.bindTvShowsSearchResultData?(itemResult.results)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    

}
