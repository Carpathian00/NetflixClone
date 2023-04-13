//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation

protocol HomeVMProtocol {
    var bindItemData: (([Item]?) -> ())? { get set }
    func fetchPopularMoviesData()
    func fetchGenresData()
}

class HomeViewModel: HomeVMProtocol {
    private let baseUrl = "https://api.themoviedb.org/3"
    private let API_KEY = "00d626f8a69df5cc36ec9689858d16b6"
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindItemData: (([Item]?) -> ())?

    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchGenresData() {
        
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
