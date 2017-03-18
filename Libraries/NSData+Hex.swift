//
//  NSData+Hex.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation


extension Data {
    
    func hexadecimalString() -> String? {
        let buffer = (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count)
        
        var hexadecimalString = ""
        for i in 0..<self.count {
            hexadecimalString += String(format: "%02x", buffer.advanced(by: i).pointee)
        }
        return hexadecimalString
    }
    
}
