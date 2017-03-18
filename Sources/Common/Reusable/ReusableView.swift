
//
//  Reusable.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}

protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}

