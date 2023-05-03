//
//  MovieDetailViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 14/04/23.
//

import Foundation

protocol MovieDetailVMProtocol {
    var bindTrailerData: ((TrailerResult?) -> ())? { get set }
    func fetchTrailerData(with movieId: Int?)
}

class MovieDetailViewModel: MovieDetailVMProtocol {
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindTrailerData: ((TrailerResult?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchTrailerData(with movieId: Int?) {
        let url = APIConfig.baseUrl + "/movie/\(movieId ?? 0)/videos" + "?api_key=\(APIConfig.API_KEY)" + "&language=en-US"
        
        self.apiServiceProtocol?.callApi(with: url, model: MovieTrailer.self, completion: { result in
            switch result {
            case .success(let success):
                var trailerData = [TrailerResult]()
                success.results.forEach { trailer in
                    if trailer.type == "Trailer" && trailer.site == "YouTube" {
                        trailerData.append(trailer)
                        print("bindtrailerdata: \(trailerData)")
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
}

