//
//  HomeInteractor.swift
//  NetflixClone
//
//  Created by PT Phincon on 17/03/25.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol {
    func fetchMoviesGenres() -> Observable<GenreApiResponse?>
    func fetchPopularMoviesInAGenre(genreId: Int) -> Observable<ItemData?>
    func fetchPopularMovies(page: Int) -> Observable<ApiResponse?>
    func fetchPopularTvShows(page: Int) -> Observable<ApiResponse?>
    func fetchTopRatedMovies(page: Int) -> Observable<ApiResponse?>
    func fetchTopRatedTvShows(page: Int) -> Observable<ApiResponse?>
}

class HomeUseCase: HomeUseCaseProtocol {
    
    private let apiServiceProtocol: APIServiceProtocol
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    func fetchMoviesGenres() -> Observable<GenreApiResponse?> {
        let genreUrl = Endpoint.genreMovieList.fullPath
        let params = ["api_key": APIConfig.API_KEY]

        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: genreUrl,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(GenreApiResponse.self, from: data)
                            if !response.genres.isEmpty {
                                observer.onNext(response)
                            } else {
                                observer.onNext(nil)
                            }
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchPopularMoviesInAGenre(genreId: Int) -> Observable<ItemData?> {
        let url = Endpoint.discoverMovie.fullPath
        let params: [String: Any] = [
            "api_key": APIConfig.API_KEY,
            "page": 1,
            "with_genres": genreId,
            "sort_by": "popularity.desc"
        ]
        
        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: url,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            guard let movies = response.results else { return }
                            if movies.count >= 5 {
                                let index = Int.random(in: 0..<5)
                                observer.onNext(movies[index])
                            } else {
                                observer.onNext(nil)
                            }
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchPopularMovies(page: Int) -> Observable<ApiResponse?> {
        let url = Endpoint.moviePopular.fullPath
        let params = [
            "api_key": APIConfig.API_KEY,
            "page": page
        ] as [String : Any]
        
        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: url,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            observer.onNext(response)
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchPopularTvShows(page: Int) -> Observable<ApiResponse?> {
        let url = Endpoint.tvPopular.fullPath
        let params = [
            "api_key": APIConfig.API_KEY,
            "page": page
        ] as [String : Any]
        
        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: url,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            observer.onNext(response)
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchTopRatedMovies(page: Int) -> Observable<ApiResponse?> {
        let url = Endpoint.discoverMovie.fullPath
        let params: [String: Any] = [
            "api_key": APIConfig.API_KEY,
            "language": "en-US",
            "sort_by": "popularity.desc",
            "page": page,
            "vote_average.gte": 7.4,
            "release_date.gte": 2020,
            "vote_count.gte": 1200,
            "release_date.lte": 2023
        ]
        
        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: url,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            observer.onNext(response)
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchTopRatedTvShows(page: Int) -> Observable<ApiResponse?> {
        let url = Endpoint.discoverTV.fullPath
        let params: [String: Any] = [
            "api_key": APIConfig.API_KEY,
            "language": "en-US",
            "sort_by": "popularity.desc",
            "page": page,
            "vote_average.gte": 7.4,
            "release_date.gte": 2020,
            "vote_count.gte": 1200,
            "release_date.lte": 2023
        ]
        
        return Observable.create { observer in
            self.apiServiceProtocol.callApi(method: .GET,
                                          url: url,
                                          headers: nil,
                                          requestBodyParams: params) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
                            observer.onNext(response)
                        } catch {
                            observer.onError(error)
                        }
                    }
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
