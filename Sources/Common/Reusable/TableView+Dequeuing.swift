//
//  TableView+Dequeuing.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
extension UITableView {
    
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNibReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }
}
