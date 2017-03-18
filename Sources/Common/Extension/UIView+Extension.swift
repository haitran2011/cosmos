//
//  UIView+Extension.swift
//  BrickInUp
//
//  Created by Hieu Trinh on 9/22/16.
//  Copyright © 2016 Vince Tran. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeRounded(with cornerRadius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    func makeBorderColor(borderColor color: UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func makeBorderWidth(boderWidth width: CGFloat) {
        self.layer.borderWidth = width
    }
    class func instanceFromNib() -> UIView {
        let nibName = self.getClassName()
        return UINib(nibName:nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    class func getClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    func findFirstResponderBeneathView(view:UIView) -> UIView? {
        for childView in view.subviews{
            let selector = childView.isFirstResponder
            if selector{
                childView.resignFirstResponder()
            }
            let result = self.findFirstResponderBeneathView(view: childView)
            if let _ = result {
                result?.resignFirstResponder()
            }
        }
        return nil
    }
    
    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
