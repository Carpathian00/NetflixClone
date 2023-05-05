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

}
