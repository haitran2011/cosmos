//
//  ColorSchema.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/15/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit
//This class to setup color schema for the app
struct ColorSchema {
    fileprivate init() {
        
    }
    
    static func mainColor() -> UIColor {
        return UIColor.orange;
    }
    
    static func blueColor() -> UIColor {
        return UIColor.blue
    }
    static func appTheme() -> UIColor{
        return UIColor(red: 6/255.0, green: 121/255.0, blue: 176/255.0, alpha: 1)
    }
    static func navibarColor() -> UIColor{
        return UIColor.white
    }
    static func mlkCoolGrey() -> UIColor {
        return UIColor(red: 171.0 / 255.0, green: 178.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkSteelGrey() -> UIColor {
        return UIColor(red: 132.0 / 255.0, green: 141.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkPaleTeal() -> UIColor {
        return UIColor(red: 133.0 / 255.0, green: 201.0 / 255.0, blue: 197.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkWhite() -> UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkDarkGrey() -> UIColor {
        return UIColor(red: 38.0 / 255.0, green: 41.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkLightGrey() -> UIColor {
        return UIColor(red: 236.0 / 255.0, green: 237.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkWhiteTwo() -> UIColor {
        return UIColor(white: 210.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkWarmGrey() -> UIColor {
        return UIColor(white: 119.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkGreenyBlue() -> UIColor {
        return UIColor(red: 71.0 / 255.0, green: 169.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0)
    }
    
    static func mlkDarkGreyTwo() -> UIColor {
        return UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    }
    
    static func mlkWhiteThree() -> UIColor {
        return UIColor(red: 219.0/255.0, green: 219.0/255.0, blue: 219.0/255.0, alpha: 1.0)
    }
}
