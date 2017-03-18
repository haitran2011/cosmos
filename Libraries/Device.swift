//
//  Device.swift
//  cosmos
//
//  Created by Tue Nguyen on 5/23/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess
extension UIDevice {
    var uniqueDeviceIdentifier: String {
        let keychain = Keychain().accessibility(.always)
        
        let keyName = "UniqueDeviceIdentifier"
        
        if let uniqueDeviceIdentifier = keychain[keyName] {
            return uniqueDeviceIdentifier
        } else {
            let uniqueDeviceIdentifier = UUID().uuidString
            keychain[keyName] = uniqueDeviceIdentifier
            return uniqueDeviceIdentifier
        }
    }
    func isIpad() -> Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    func isIphone()-> Bool{
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
