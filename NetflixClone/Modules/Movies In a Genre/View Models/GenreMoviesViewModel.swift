//
//  GenreMoviesViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 02/05/23.
//

import Foundation

protocol GenreMoviesVMDelegate {
    func fetchMoviesByTheGenre(genreId: Int, currentPage: Int)
    var bindMoviesData: (([Item]?) -> Void)? { get set }
}


class GenreMoviesViewModel: GenreMoviesVMDelegate {
    
    private var apiServiceProtocol: APIServiceProtocol?
    var bindMoviesData: (([Item]?) -> Void)?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    func fetchMoviesByTheGenre(genreId: Int, currentPage: Int) {
        let url = APIConfig.baseUrl + "/discover/movie" + "?api_key=\(APIConfig.API_KEY)&with_genres=\(genreId)&page=\(currentPage)"
        
        self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
            switch result {
            case .success(let success):
                self.bindMoviesData?(success.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
        
    }

}
