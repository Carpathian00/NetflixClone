//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 13/04/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class HomeViewModel {
    
    private var apiServiceProtocol: APIServiceProtocol?
    private var useCase: HomeUseCaseProtocol
    private let disposeBag = DisposeBag()
    
    internal var onReloadSection = PublishSubject<TableSections>()
    internal var onSetHeader = PublishSubject<ItemData>()
    internal var popularMoviesData: [ItemData]?
    internal var genreData: [Genre]?
    internal var topRatedMoviesData: [ItemData]?
    internal var popularTvShowsData: [ItemData]?
    internal var topRatedTvShowsData: [ItemData]?
    
    init() {
        self.apiServiceProtocol = APIService()
        self.useCase = HomeUseCase()
    }
    
    func getGenresData() {
        useCase.fetchMoviesGenres()
            .observe(on: MainScheduler.instance)
            .compactMap({ $0?.genres })
            .flatMap({ genres -> Observable<[Genre]> in
                
                let genreObservables = genres.map { genre in
                    return self.useCase.fetchPopularMoviesInAGenre(genreId: genre.id ?? 0)
                        .map { movie -> Genre in
                            var updatedGenre = genre
                                  updatedGenre.imagePath = movie?.posterPath
                                  return updatedGenre
                        }
                }
                
                return Observable.zip(genreObservables)
            })
            .subscribe(
                onNext: { [weak self] updatedGenre in
                    self?.genreData = updatedGenre
                    self?.onReloadSection.onNext(.genres)
                },
                onError: { err in
                    print(err.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    func getPopularMoviesData(currentPage: Int) {
        useCase.fetchPopularMovies(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self,
                      let movies = response,
                      !movies.results.isEmpty else { return }
                
                if let headerTitle = movies.results.randomElement() {
                    self.onSetHeader.onNext(headerTitle)
                }
                self.popularMoviesData = movies.results
                self.onReloadSection.onNext(.popularMovies)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getPopularTvShowsData(currentPage: Int) {
        useCase.fetchPopularTvShows(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self,
                      let shows = response,
                      !shows.results.isEmpty else { return }
                
                self.popularTvShowsData = shows.results
                self.onReloadSection.onNext(.popularTvShows)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getTopRatedMoviesData(currentPage: Int) {
        useCase.fetchTopRatedMovies(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self,
                      let movies = response,
                      !movies.results.isEmpty else { return }
                
                self.topRatedMoviesData = movies.results
                self.onReloadSection.onNext(.topRatedMovies)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getTopRatedTvShowsData(currentPage: Int) {
        useCase.fetchTopRatedTvShows(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self,
                      let shows = response,
                      !shows.results.isEmpty else { return }
                
                self.topRatedTvShowsData = shows.results
                self.onReloadSection.onNext(.topRatedTvShows)
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
