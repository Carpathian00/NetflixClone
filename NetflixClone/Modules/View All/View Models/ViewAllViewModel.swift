//
//  ViewAllViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 26/04/23.
//

import Foundation

class ViewAllViewModel {
    
    var bindItemData: (([Item]?) -> ())?
    let selectedSection: Int
    private let homeVM = HomeViewModel()
    private var currentPage: Int?
    

    init(selectedSection: Int) {
        self.selectedSection = selectedSection
    }
    
    func getData(currentPage: Int) {
        self.currentPage = currentPage
        let section = TableSections(rawValue: selectedSection)
        
        switch section {
        case .popularMovies:
            getPopularMoviesData()
        case .popularTvShows:
            getPopularTvShowsData()
        case .topRatedMovies:
            getTopRatedMoviesData()
        case .topRatedTvShows:
            getTopRatedTvShowsData()
        default:
            return
        }
    }
    
    func getPopularMoviesData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.fetchPopularMoviesData(currentPage: currentPage)
        self.homeVM.bindPopularMoviesData = { result in
            self.bindItemData?(result)
        }
    }
    
    func getPopularTvShowsData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.fetchPopularTvShowsData(currentPage: currentPage)
        self.homeVM.bindPopularTvShowsData = { result in
            self.bindItemData?(result)
        }

    }
    
    func getTopRatedMoviesData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.fetchTopRatedMoviesData(currentPage: currentPage)
        self.homeVM.bindtopRatedMoviesData = { result in
            self.bindItemData?(result)
        }
    }
    
    func getTopRatedTvShowsData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.fetchTopRatedTvShowsData(currentPage: currentPage)
        self.homeVM.bindTopRatedTvShowsData = { result in
            self.bindItemData?(result)
        }

    }
    
    
    
}
