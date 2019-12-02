//
//  DSColors.swift
//  movie-list
//
//  Created by Marcellus Selga Batista on 22/11/19.
//  Copyright © 2019 Marcellus Selga Batista. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: - Design System Colors
    
    @nonobjc class var dsNavbarBG: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 200/255, green: 200/255, blue: 220/255, alpha: 1) :
            UIColor(red: 20/255, green: 30/255, blue: 40/255, alpha: 1)
    }
    
    @nonobjc class var dsBGPrimary: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 240/255, green: 240/255, blue: 255/255, alpha: 1) :
            UIColor(red: 50/255, green: 50/255, blue: 60/255, alpha: 1)
    }
    
    @nonobjc class var dsTextPrimary: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9) :
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
    }
    
    @nonobjc class var dsTextSecondary: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6) :
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
    }
    
    @nonobjc class var dsHighlight: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 204/255, green: 140/255, blue: 23/255, alpha: 1) :
            UIColor(red: 204/255, green: 140/255, blue: 23/255, alpha: 1)
    }
    
    @nonobjc class var dsDisable: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 0.5) :
            UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 0.6)
    }
    
    @nonobjc class var dsRed: UIColor {
        return DSTheme.shared.type == .light ?
            UIColor(red: 176/255, green: 0/255, blue: 32/255, alpha: 1) :
            UIColor(red: 176/255, green: 0/255, blue: 32/255, alpha: 0.8)
    }
    
    //MARK: - Cross Theme colors
    
    @nonobjc class var dsTextDarkCross: UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.9)
    }
    
    @nonobjc class var dsTextLightCross: UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)
    }
}
