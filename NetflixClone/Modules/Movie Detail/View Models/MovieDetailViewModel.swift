//
//  MovieDetailViewModel.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 14/04/23.
//

import Foundation


class MovieDetailViewModel {
    
    private var apiServiceProtocol: APIServiceProtocol?
    
    var bindItemData: (([Item]?) -> ())?
    var bindGenreData: (([Genre]?) -> ())?
    
    init() {
        self.apiServiceProtocol = APIService()
    }
    
    
    func fetchTrailerData() {
        
    }
    
    
    
}

