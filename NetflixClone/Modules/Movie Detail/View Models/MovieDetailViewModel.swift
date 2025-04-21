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
        let url = APIConfig.baseUrl + "/movie/\(id ?? 0)/videos"
        let params = [
            "api_key": APIConfig.API_KEY,
            "language": "en-US"
        ]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let trailerResponse = try? JSONDecoder().decode(MovieTrailer.self, from: data) {
                    DispatchQueue.main.async {
                        var trailerData = [TrailerResult]()
                        trailerResponse.results.forEach { trailer in
                            if trailer.type == "Trailer" && trailer.site == "YouTube" {
                                trailerData.append(trailer)
                                return
                            }
                        }
                        if !trailerData.isEmpty {
                            self?.bindTrailerData?(trailerData.first)
                        } else {
                            self?.bindTrailerData?(nil)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.bindTrailerData?(nil)
            }
        }
    }
    
    func fetchMovieDetail(with movieId: Int?) {
        let url = APIConfig.baseUrl + "/movie/\(movieId ?? 0)"
        let params = [
            "api_key": APIConfig.API_KEY,
            "language": "en-US"
        ]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    DispatchQueue.main.async {
                        self?.bindMovieDetailData?(movieDetail)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTvDetail(with tvId: Int?) {
        let url = APIConfig.baseUrl + "/tv/\(tvId ?? 0)"
        let params = [
            "api_key": APIConfig.API_KEY,
            "language": "en-US"
        ]
        
        self.apiServiceProtocol?.callApi(method: .GET, url: url, headers: nil, requestBodyParams: params) { [weak self] result in
            switch result {
            case .success(let data):
                if let data = data,
                   let tvDetail = try? JSONDecoder().decode(TvDetail.self, from: data) {
                    DispatchQueue.main.async {
                        self?.bindTvShowsData?(tvDetail)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
