//
//  UIView+NibLocalize.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/8/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit

protocol Localizable {
    func displayLocalized()
}

extension UIView: Localizable {
    func displayLocalized() {
        
    }
}

extension UILabel {
    override func displayLocalized() {
        if let text = self.text {
            self.text = NSLocalizedString(text, comment: "")
        }
    }
}

extension UIButton {
    override func displayLocalized() {
        let allStates: [UIControlState] = [.highlighted, .disabled, .selected]
        for state in allStates {
            if let title = title(for: state) {
                setTitle(NSLocalizedString(title, comment: ""), for:state)
            }
        }
        
    }
}

extension UITextField {
    override func displayLocalized() {
        if let text = self.text {
            self.text = NSLocalizedString(text, comment: "")
        }
        
        if let placeholder = self.placeholder {
            self.placeholder = NSLocalizedString(placeholder, comment: "")
        }
    }
}

extension UITextView {
    override func displayLocalized() {
        if let text = self.text {
            self.text = NSLocalizedString(text, comment: "")
        }
    }
}

extension UIToolbar {
    override func displayLocalized() {
        if let items = self.items {
            for item in items {
                if let title = item.title {
                    item.title = NSLocalizedString(title, comment: "")
                }
            }
        }
    }
}
