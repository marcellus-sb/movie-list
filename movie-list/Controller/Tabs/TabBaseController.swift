//
//  TabBaseController.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 01/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class TabBaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyBaseStyle()
    }
    
    //MARK: - Private Methods
    
    private func applyBaseStyle() {
        //Navigation Bar
        self.navigationController?.navigationBar.barTintColor = .dsNavbarBG
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.dsTextPrimary]
        
        //Controller
        self.view.backgroundColor = .dsBGPrimary
    }
    
}
