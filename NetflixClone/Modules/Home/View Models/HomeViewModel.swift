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
    func fetchPopularMoviesData(currentPage: Int)
    func fetchAPopularMovieInAGenre(with genreId: Int, completion: @escaping (Item?) -> Void)
    func fetchGenresData()
}

class HomeViewModel: HomeVMProtocol {
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindItemData: (([Item]?) -> ())?
    var bindGenreData: (([Genre]?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchGenresData() {
        let genreUrl = APIConfig.baseUrl + "/genre/movie/list" + "?api_key=\(APIConfig.API_KEY)"
        
        self.apiServiceProtocol?.callApi(with: genreUrl, model: GenreApiResponse.self, completion: { result in
            switch result {
            case .success(let genreResponse):
                
                var genres = genreResponse.genres
                
                for i in 0..<genres.count {
                    let genreId = genres[i].id
                    self.fetchAPopularMovieInAGenre(with: genreId ?? 0) { firstMovie in
                        if let firstMovie = firstMovie {
                            genres[i].imagePath = firstMovie.posterPath
                            self.bindGenreData?(genres)
                        } else {
                            self.bindGenreData?(nil)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.bindGenreData?(nil)
            }
        })
    }
    
    func fetchAPopularMovieInAGenre(with genreId: Int, completion: @escaping (Item?) -> Void) {
        let popularMoviesGenre = APIConfig.baseUrl + "/movie/popular" + "?api_key=\(APIConfig.API_KEY)" + "&page=1" + "&with_genres=\(genreId)"
        
        self.apiServiceProtocol?.callApi(with: popularMoviesGenre, model: ApiResponse.self, completion: { result in
            switch result {
            case .success(let apiResponse):
                
                if apiResponse.results.count >= 3 {
                    completion(apiResponse.results[2])
                } else {
                    completion(nil)
                }
                    
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        })
    }
    
    func fetchPopularMoviesData(currentPage: Int) {
        let url = APIConfig.baseUrl + "/movie/popular" + "?api_key=\(APIConfig.API_KEY)" + "&page=\(currentPage)"

            self.apiServiceProtocol?.callApi(with: url, model: ApiResponse.self, completion: { result in
                switch result {
                case .success(let success):
                    self.bindItemData?(success.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}
