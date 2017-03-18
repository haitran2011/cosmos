//
//  AppTheming.swift
//  MilkyChat
//
//  Created by Thanh Nguyen on 12/26/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit

class AppTheming {
    
    class func setupNavigationTheming(barColor color:UIColor) {
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().isTranslucent = false
    }
}
