//
//  ViewAllViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 26/04/23.
//

import Foundation
import RxSwift
import RxCocoa

protocol MediaResponseProtocol {
    var results: [ItemData]? { get }
}

class ViewAllViewModel {
    
    var bindItemData: (([ItemData]?) -> ())?
    let selectedSection: Int
    private var useCase: HomeUseCaseProtocol
    private var currentPage: Int
    private let homeVM = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    init(selectedSection: Int) {
        self.selectedSection = selectedSection
        self.useCase = HomeUseCase()
        self.currentPage = 0
    }
    
    func getData(currentPage: Int) {
        self.currentPage = currentPage
        guard let section = TableSections(rawValue: selectedSection),
              let fetcher = fetchMap[section] else { return }
        fetcher(currentPage)
    }
    
    private lazy var fetchMap: [TableSections: (Int) -> Void] = [
        .popularMovies: fetch(self.useCase.fetchPopularMovies),
        .popularTvShows: fetch(self.useCase.fetchPopularTvShows),
        .topRatedMovies: fetch(self.useCase.fetchTopRatedMovies),
        .topRatedTvShows: fetch(self.useCase.fetchTopRatedTvShows)
    ]
    
    private func fetch<T: MediaResponseProtocol>(_ apiCall: @escaping (Int) -> Observable<T?>) -> (Int) -> Void {
        return { [weak self] page in
            guard let self = self else { return }
            apiCall(page)
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onNext: { [weak self] response in
                        self?.bindItemData?(response?.results)
                    },
                    onError: { err in
                        print(err.localizedDescription)
                    }
                ).disposed(by: disposeBag)
        }
    }
    
    func getPopularMoviesData() {
        self.useCase.fetchPopularMovies(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    self.bindItemData?(response?.results)
                },
                onError: { error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    func getPopularTvShowsData() {
        self.useCase.fetchPopularTvShows(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    self.bindItemData?(response?.results)
                },
                onError: { error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    func getTopRatedMoviesData() {
        self.useCase.fetchTopRatedMovies(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    self.bindItemData?(response?.results)
                },
                onError: { error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
    
    func getTopRatedTvShowsData() {
        self.useCase.fetchTopRatedTvShows(page: currentPage)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    guard let self = self else { return }
                    self.bindItemData?(response?.results)
                },
                onError: { error in
                    print(error.localizedDescription)
                }
            ).disposed(by: disposeBag)
    }
}
