//
//  GenreMoviesViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 02/05/23.
//

import Foundation

protocol GenreMoviesVMDelegate {
    func fetchMoviesByTheGenre(genreId: Int, currentPage: Int)
    var bindMoviesData: (([ItemData]?) -> Void)? { get set }
}

class GenreMoviesViewModel: GenreMoviesVMDelegate {
    
    private var apiServiceProtocol: APIServiceProtocol?
    var bindMoviesData: (([ItemData]?) -> Void)?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    func fetchMoviesByTheGenre(genreId: Int, currentPage: Int) {
        let url = APIConfig.baseUrl + "/discover/movie"
        let reqBody: [String: Any] = [
            "api_key": APIConfig.API_KEY,
            "with_genres": genreId,
            "page": currentPage
        ]

        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: reqBody, completion: { result in
            switch result {
            case .success(let data):
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                        self.bindMoviesData?(response.results)
                    } catch {
                        self.bindMoviesData?(nil)
                    }
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
