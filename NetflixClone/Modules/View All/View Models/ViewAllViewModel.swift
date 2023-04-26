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
    

    init(selectedSection: Int) {
        self.selectedSection = selectedSection
    }
    
    func getData() {
        let section = TableSections(rawValue: selectedSection)
        
        switch section {
        case .movies:
            self.homeVM.fetchPopularMoviesData()
            self.homeVM.bindItemData = { result in
                self.bindItemData?(result)
            }
        default:
            return
        }
    }
    
    
    
}
