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
    
}
