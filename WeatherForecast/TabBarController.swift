//
//  TabBarController.swift
//  WeatherForecast
//
//  Created by Maxim Kucherov on 24/11/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupTabBar()
        
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let map = createNav(with: "Map", and: UIImage(systemName: "map"), vc: MapViewController())
        let search = createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: SearchViewController())
        let favorites = createNav(with: "Favorites", and: UIImage(systemName: "star"), vc: FavoritesViewController())
    
        setViewControllers([map, search, favorites], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nc = UINavigationController(rootViewController: vc)
        nc.tabBarItem.title = title
        nc.tabBarItem.image = image
        
        // Добавляем следующие строки для отображения Navigation Bar на вершине каждого UINavigationController
        if !(vc is MapViewController) {
            vc.navigationItem.title = title
        }
        nc.navigationBar.prefersLargeTitles = true
        nc.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        return nc
    }
    
    private func setupTabBar() {
        tabBar.barTintColor = .black
        tabBar.tintColor = .purple
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
    }
    
}
