//
//  ViewAllViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 26/04/23.
//

import Foundation

class ViewAllViewModel {
    var bindItemData: (([ItemData]?) -> ())?
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
        self.homeVM.getPopularMoviesData(currentPage: currentPage)
        self.bindItemData?(self.homeVM.popularMoviesData)
    }
    
    func getPopularTvShowsData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.getPopularTvShowsData(currentPage: currentPage)
        self.bindItemData?(self.homeVM.popularTvShowsData)
    }
    
    func getTopRatedMoviesData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.getTopRatedMoviesData(currentPage: currentPage)
        self.bindItemData?(self.homeVM.topRatedMoviesData)
    }
    
    func getTopRatedTvShowsData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.getTopRatedTvShowsData(currentPage: currentPage)
        self.bindItemData?(self.homeVM.topRatedTvShowsData)
    }
}
