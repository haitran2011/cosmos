//
//  UITextView+Extension.swift
//  MilkyChat
//
//  Created by HieuiOS on 1/11/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import UIKit

extension UITextView{
//    public func setText(text: String, withHashtagColor hashtagColor: UIColor, andMentionColor mentionColor: UIColor, andCallBack callBack: (String, wordType) -> Void, font: UIFont) {
//        //self.callBack = callBack
//        var attrString = NSMutableAttributedString(string: text)
//        self.attrString = attrString
//        var textString = NSString(string: text)
//        self.textString = textString
//        
//        // Set initial font attributes for our string
//        attrString.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: textString.length))
//        
//        // Call a custom set Hashtag and Mention Attributes Function
//        setAttrWithName(attrName: "Hashtag", wordPrefix: "#", color: hashtagColor, text: text)
//        setAttrWithName(attrName: "Mention", wordPrefix: "@", color: mentionColor, text: text)
//        
//        // Add tap gesture that calls a function tapRecognized when tapped
//        let tapper = UITapGestureRecognizer(target: self, action: "tapRecognized:")
//        addGestureRecognizer(tapper)
//    }
//    func setAttrWithName(attrName: String, wordPrefix: String, color: UIColor, text: String) {
//        let words = text.componentsSeparatedByString(" ")
//        
//        for word in words.filter({$0.hasPrefix(wordPrefix)}) {
//            let range = textString!.rangeOfString(word)
//            attrString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
//            attrString.addAttribute(attrName, value: 1, range: range)
//            attrString.addAttribute("Clickable", value: 1, range: range)
//        }
//        self.attributedText = attrString
//    }
//    func tapRecognized(tapGesture: UITapGestureRecognizer) {
//        // Gets the range of word at current position
//        var point = tapGesture.locationInView(self)
//        var position = closestPositionToPoint(point)
//        let range = tokenizer.rangeEnclosingPosition(position, withGranularity: .Word, inDirection: 1)
//        
//        if range != nil {
//            let location = offsetFromPosition(beginningOfDocument, toPosition: range!.start)
//            let length = offsetFromPosition(range!.start, toPosition: range!.end)
//            let attrRange = NSMakeRange(location, length)
//            let word = attributedText.attributedSubstringFromRange(attrRange)
//            
//            // Checks the word's attribute, if any
//            let isHashtag: AnyObject? = word.attribute("Hashtag", atIndex: 0, longestEffectiveRange: nil, inRange: NSMakeRange(0, word.length))
//            let isAtMention: AnyObject? = word.attribute("Mention", atIndex: 0, longestEffectiveRange: nil, inRange: NSMakeRange(0, word.length))
//            
//            // Runs callback function if word is a Hashtag or Mention
//            if isHashtag != nil && callBack != nil {
//                callBack!(word.string, wordType.Hashtag)
//            } else if isAtMention != nil && callBack != nil {
//                callBack!(word.string, wordType.Mention)
//            }
//        }
//    }
//    @IBOutlet var textView: UITextView!
//    
//    override func viewDidLoad() {
//        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
//        attributedString.addAttribute(NSLinkAttributeName, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
//        
//        textView.attributedText = attributedString
//    }
//    
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL, options: [:])
//        return false
//    }
}
