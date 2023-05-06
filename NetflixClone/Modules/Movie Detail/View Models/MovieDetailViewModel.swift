//
//  MovieDetailViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 14/04/23.
//

import Foundation

protocol MovieDetailVMProtocol {
    var bindTrailerData: ((TrailerResult?) -> ())? { get set }
    var bindMovieDetailData: ((MovieDetail?) -> ())? { get set }
    var bindTvShowsData: ((TvDetail?) -> ())? { get set }
    func fetchTrailerData(with id: Int?)
    func fetchMovieDetail(with movieId: Int?)
    func fetchTvDetail(with tvId: Int?)
}

class MovieDetailViewModel: MovieDetailVMProtocol {
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindTrailerData: ((TrailerResult?) -> ())?
    var bindMovieDetailData: ((MovieDetail?) -> ())?
    var bindTvShowsData: ((TvDetail?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchTrailerData(with id: Int?) {
        let url = APIConfig.baseUrl + "/movie/\(id ?? 0)/videos" + "?api_key=\(APIConfig.API_KEY)" + "&language=en-US"
        
        self.apiServiceProtocol?.callApi(with: url, model: MovieTrailer.self, completion: { result in
            switch result {
            case .success(let success):
                var trailerData = [TrailerResult]()
                success.results.forEach { trailer in
                    if trailer.type == "Trailer" && trailer.site == "YouTube" {
                        trailerData.append(trailer)
                        return
                    }
                }
                guard let bindTrailerData = self.bindTrailerData else { return }
                if !trailerData.isEmpty {
                    bindTrailerData(trailerData.first)
                } else {
                    self.bindTrailerData?(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.bindTrailerData?(nil)

            }
        })
    }
    
    func fetchMovieDetail(with movieId: Int?) {
        let url = APIConfig.baseUrl + "/movie/\(movieId ?? 0)" + "?api_key=\(APIConfig.API_KEY)" + "&language=en-US"
        
        self.apiServiceProtocol?.callApi(with: url, model: MovieDetail.self, completion: { result in
            print("Movie detail result: \(movieId)")

            switch result {
            case .success(let movieDetail):
                self.bindMovieDetailData?(movieDetail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchTvDetail(with tvId: Int?) {
        let url = APIConfig.baseUrl + "/tv/\(tvId ?? 0)" + "?api_key=\(APIConfig.API_KEY)" + "&language=en-US"
        
        self.apiServiceProtocol?.callApi(with: url, model: TvDetail.self, completion: { result in

            switch result {
            case .success(let tvDetail):
                self.bindTvShowsData?(tvDetail)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })


    }
    

    
    
}

