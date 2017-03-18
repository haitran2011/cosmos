//
//  StoryboardIdentifiable.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable: class {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: ViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

