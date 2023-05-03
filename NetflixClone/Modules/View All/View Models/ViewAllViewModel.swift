//
//  ViewAllViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 26/04/23.
//

import Foundation

class ViewAllViewModel {
    
    var bindItemData: (([Item]?) -> ())?
    var bindTopRatedMoviesData: (([Item]?) -> ())?
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
            getMoviesData()
        case .topRatedMovies:
            getTopRatedMoviesData()
        default:
            return
        }
    }
    
    func getMoviesData() {
        guard let currentPage = self.currentPage else { return }
        self.homeVM.fetchPopularMoviesData(currentPage: currentPage)
        self.homeVM.bindItemData = { result in
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
    
    
    
}
