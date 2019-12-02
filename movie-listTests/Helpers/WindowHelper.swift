//
//  WindowHelper.swift
//  movie-listTests
//
//  Created by Marcellus Selga Batista on 02/12/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

class WindowHelper {
    
    static var testWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        return window
    }()
    
    static func showInTestWindow(viewController: UIViewController) {
        WindowHelper.testWindow.rootViewController = viewController
        WindowHelper.testWindow.makeKeyAndVisible()
    }
    
    static func cleanTestWindow() {
        WindowHelper.testWindow.rootViewController = nil
        WindowHelper.testWindow.isHidden = true
    }
}
