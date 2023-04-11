//
//  LeftNavBar.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 10/04/23.
//

import UIKit

class LeftNavBarItems: UIBarButtonItem {
    private let appLogo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "netflixLogo")
        
        NSLayoutConstraint.activate([
            img.centerYAnchor.constraint(equalTo: img.centerYAnchor)
        ])
        
        return img
    }()
    
    func setupLeftNavBarItems() {
        self.customView = appLogo
    }
    
}
