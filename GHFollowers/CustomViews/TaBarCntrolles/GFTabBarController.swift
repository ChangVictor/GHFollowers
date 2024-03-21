//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Victor Chang on 21/03/2024.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavController(), createFavoritesNavController()]
    }
    
    func createSearchNavController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchViewController)
    }
    
    func createFavoritesNavController() -> UINavigationController {
        let favoriteViewController = FavoritesViewController()
        favoriteViewController.title = "Favorites"
        favoriteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteViewController)
    }
}
