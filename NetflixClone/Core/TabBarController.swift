//
//  TabBarController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
    }
    
    func setupViewControllers() {
        self.viewControllers = [
            createController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house")!),
            createController(for: SearchViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")!),
            createController(for: SavedViewController(), title: "Saved", image: UIImage(systemName: "bookmark")!),
            createController(for: ProfileViewController(), title: "Profile", image: UIImage(systemName: "person")!)
        ]
    }
    

    private func createController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        
        return navigationController
    }

}
