//
//  CellConfigurable.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

protocol CellConfigurable: class {
    
    associatedtype Controller
    var cellController: Controller? { get set }
}
