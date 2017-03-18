//
//  CollectionView+Dequeuing.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension UICollectionView{
    
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerNibReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable, T: NibLoadable {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: NSIndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}
