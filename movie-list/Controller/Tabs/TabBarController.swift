//
//  TabBarController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 02/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Constants
    
    private let DEFAULT_TAB_INDEX = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTabs()
        self.config()
        self.applyStyle()
    }
    
    private func applyStyle() {
        self.tabBar.tintColor = .dsTextDarkCross
        self.tabBar.barTintColor = .dsRed
    }
    
    private func config() {
        self.selectedIndex = DEFAULT_TAB_INDEX
    }
    
    private func createTabs() {
        let favoritesListNavigation = UINavigationController(rootViewController: FavoritesController())
        favoritesListNavigation.tabBarItem.image = R.image.heart()
        favoritesListNavigation.tabBarItem.title = R.string.common.favorites()
        
        let moviesListNavigation = UINavigationController(rootViewController: MoviesListController())
        moviesListNavigation.tabBarItem.image = R.image.list()
        moviesListNavigation.tabBarItem.title = R.string.common.movies()
        
        let configNavigation = UINavigationController(rootViewController: ConfigurationController())
        configNavigation.tabBarItem.image = R.image.settings()
        configNavigation.tabBarItem.title = R.string.common.settings()
        
        self.viewControllers = [
            favoritesListNavigation,
            moviesListNavigation,
            configNavigation
        ]
    }
    
    
}
