//
//  TabBarController.swift
//  NetflixClone
//
//  Created by Adlan Nourindiaz on 06/04/23.
//

import UIKit

protocol TabBarControllerDelegate {
    func moveToDetailPage(model: Item?, fromTableHeader: Bool, isPlayOnly: Bool, navCon: UINavigationController)
    func moveToViewAllPage(section: Int, navCon: UINavigationController)
    func moveToGenreMoviesPage(genre: Genre?, navCon: UINavigationController)
    func moveToLoginPage(navCon: UINavigationController)
}


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
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let profileVC = ProfileViewController()
        homeVC.tabBarDelegate = self
        searchVC.tabBarDelegate = self
        profileVC.tabBarDelegate = self

        
        self.viewControllers = [
            createController(for: homeVC, title: "Home", image: UIImage(systemName: "house")!),
            createController(for: searchVC, title: "Search", image: UIImage(systemName: "magnifyingglass")!),
//            createController(for: SavedViewController(), title: "Saved", image: UIImage(systemName: "bookmark")!),
            createController(for: profileVC, title: "Profile", image: UIImage(systemName: "person")!)
        ]
    }
    

    private func createController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        
        return navigationController
    }

}

extension TabBarController: TabBarControllerDelegate {
    
    func moveToDetailPage(model: Item?, fromTableHeader: Bool, isPlayOnly: Bool, navCon: UINavigationController) {
        let vc = MovieDetailViewController()
        vc.configure(model: model, fromTableHeader: fromTableHeader, isPlayOnly: isPlayOnly)
        
        if fromTableHeader == true {
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            navCon.present(vc, animated: true, completion: nil)
        } else {
            navCon.pushViewController(vc, animated: true)
        }
    }

    func moveToViewAllPage(section: Int, navCon: UINavigationController) {
        let vc = ViewAllViewController()
        vc.configure(section: section)
        vc.homeVCDelegate = self
        navCon.pushViewController(vc, animated: true)
        navCon.isNavigationBarHidden = false
        print("clicked")

    }
    
    func moveToGenreMoviesPage(genre: Genre?, navCon: UINavigationController) {
        let vc = GenreMoviesViewController()
        vc.configure(genre: genre)
        vc.homeVCDelegate = self
        navCon.pushViewController(vc, animated: true)
        navCon.isNavigationBarHidden = false
    }
    
    func moveToLoginPage(navCon: UINavigationController) {
        let loginController = LoginViewController()
         
        view.window?.rootViewController = UINavigationController(rootViewController: loginController)

    }
}


