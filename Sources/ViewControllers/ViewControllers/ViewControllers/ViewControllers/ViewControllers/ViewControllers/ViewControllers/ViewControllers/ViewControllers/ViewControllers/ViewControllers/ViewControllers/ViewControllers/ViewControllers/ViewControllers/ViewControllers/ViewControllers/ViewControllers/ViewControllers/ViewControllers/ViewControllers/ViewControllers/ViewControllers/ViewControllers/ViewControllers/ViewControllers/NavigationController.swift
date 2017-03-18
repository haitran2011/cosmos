//
//  NavigationController.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/8/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
}

extension UIViewController {
    func embedInNavigationController() -> NavigationController {
        let navigationController = NavigationController(rootViewController: self)
        
        return navigationController
    }
}