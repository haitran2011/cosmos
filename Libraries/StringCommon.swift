//
//  StringCommon.swift
//  MilkyChat
//
//  Created by Tue Nguyen on 6/6/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit

extension String {
    /**
     Return length of the current string
     */
    var length: Int {
        return characters.count
    }
    
    /**
     Triming white space from start and end of the string
     */
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func contains(_ s: String) -> Bool
    {
        return (self.range(of: s) != nil) ? true : false
    }
    func contains(_ s: String , sensitive: Bool) -> Bool{
        if sensitive {
            return (self.lowercased().range(of: s.lowercased()) != nil) ? true : false
        }else{
            return (self.range(of: s) != nil) ? true : false
        }
    }
    func replace(_ target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    subscript (i: Int) -> Character
        {
        get {
            let index = characters.index(startIndex, offsetBy: i)
            return self[index]
        }
    }
    subscript (r: Range<Int>) -> String
        {
        get {
            let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound)
            return self[startIndex..<endIndex]
        }
    }
    func subString(_ startIndex: Int, length: Int) -> String
    {
        let start = self.characters.index(self.startIndex, offsetBy: startIndex)
        let end = self.characters.index(self.startIndex, offsetBy: startIndex + length)
        return self.substring(with: Range<String.Index>(start..<end))
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
    
    func widthForLabel(withFont font: UIFont, availableHeight height: CGFloat) -> CGFloat {
        let size = CGSize(width: 200.0, height: height)
        let actualSize = (self as NSString).boundingRect(with: size,
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: font], context: nil)
        return actualSize.width
    }
    
    
    func heightForLabel(withFont font: UIFont, availableWidth width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = (self as NSString).boundingRect(with: size,
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName: font], context: nil)
        
        return actualSize.height
    }
}
/**
 * String file path processing
 */
extension String {
    public var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    public var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    public func stringByAppendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    public var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    public var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    public func stringByAppendingPathExtension(_ str: String) -> String? {
        return (self as NSString).appendingPathExtension(str)
    }
}
//Check if Swift string contains an emoji or dingbat charater
extension String {
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
}
