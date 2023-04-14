//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation

protocol HomeVMProtocol {
    var bindItemData: (([Item]?) -> ())? { get set }
    var bindGenreData: (([Genre]?) -> ())? { get set }
    func fetchPopularMoviesData()
    func fetchGenresData()
}

class HomeViewModel: HomeVMProtocol {
    
    
    private let baseUrl = "https://api.themoviedb.org/3"
    private let API_KEY = "00d626f8a69df5cc36ec9689858d16b6"
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindItemData: (([Item]?) -> ())?
    var bindGenreData: (([Genre]?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchGenresData() {
        let url = baseUrl + "/genre/movie/list" + "?api_key=\(API_KEY)"
        
        self.apiServiceProtocol?.callApi(with: url, model: GenreApiResponse.self, completion: { result in
            print("result of genre: \(result)")
            switch result {
                
            case .success(let success):
                self.bindGenreData?(success.genres)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchPopularMoviesData() {
        let url = baseUrl + "/movie/popular" + "?api_key=\(API_KEY)"
        
        self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
//            print("result data: \(result)")
            switch result {
            case .success(let success):
                self.bindItemData?(success.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    
    
    
    
}
