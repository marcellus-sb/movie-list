//
//  DSTheme.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 22/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

final class DSTheme {
    enum DSThemeType {
        case light
        case dark
    }
    
    private (set) var type: DSThemeType = .dark
    
    static let shared = DSTheme()
    
    init() {
        if #available(iOS 12.0, *) {
            if UIScreen.main.traitCollection.userInterfaceStyle == .light {
                self.type = .light
            } else {
                self.type = .dark
            }
        }
    }
    
}
