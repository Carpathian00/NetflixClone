//
//  RightNavItem.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 10/04/23.
//

import UIKit

class RightNavBarItems: UIBarButtonItem {
//    private let barStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.distribution = .fillEqually
//        stackView.alignment = .fill
//        stackView.spacing = 10
//        return stackView
//    }()
//
//    private let castIcon: UIButton = {
//        let button = UIButton()
////        let image = UIImage(systemName: "airplayvideo")
//        let image = UIImage(systemName: "magnifyingglass")
//        button.setImage(image, for: .normal)
//        button.imageView?.contentMode = .scaleAspectFill
//        button.tintColor = .label
//
//        NSLayoutConstraint.activate([
//            button.heightAnchor.constraint(equalToConstant: 40),
//            button.widthAnchor.constraint(equalTo: button.heightAnchor)
//        ])
//
//        return button
//    }()
//
//    private let userIcon: UIButton = {
//        let button = UIButton()
//        let image = UIImage(named: "person1")
//        button.setImage(image, for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
//        button.tintColor = .label
//
//        NSLayoutConstraint.activate([
//            button.heightAnchor.constraint(equalToConstant: 40),
//            button.widthAnchor.constraint(equalTo: button.heightAnchor)
//        ])
//
//        return button
//    }()
//
//    func setupRightNavBarItems() {
//        barStackView.addArrangedSubview(castIcon)
//        barStackView.addArrangedSubview(userIcon)
//
//        self.customView = barStackView
//    }
    private lazy var searchButton: UIButton = {
        let image = UIImage(systemName: "airplayvideo")
        
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        
//        NSLayoutConstraint.activate([
//            button.widthAnchor.constraint(equalToConstant: 25),
//            button.heightAnchor.constraint(equalTo: button.widthAnchor)
//        ])
        
        return button
    }()
    
    private lazy var profileButton: UIButton = {
        let image = UIImage(named: "person1")
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 25),
            button.heightAnchor.constraint(equalTo: button.widthAnchor)
        ])
        
        return button
    }()
    
    private lazy var barStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()

    
    func setupBarItem() {
        barStackView.addArrangedSubview(searchButton)
        barStackView.addArrangedSubview(profileButton)
                
        self.customView = barStackView
    }

}
