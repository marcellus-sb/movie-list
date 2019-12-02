//
//  AppDelegate.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 20/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = R.storyboard.main.instantiateInitialViewController()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

