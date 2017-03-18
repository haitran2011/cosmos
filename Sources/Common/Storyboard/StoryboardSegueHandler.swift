//
//  StoryboardSegueHandler.swift
//  cosmos
//
//  Created by HieuiOS on 2/4/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController,
    SegueIdentifier.RawValue == String{
    
    func performSegueWithIdentifier(_ segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {
        
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else { fatalError("Invalid segue identifier \(segue.identifier).") }
        
        return segueIdentifier
    }
}
