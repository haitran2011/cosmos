//
//  ViewController.swift
//  MilkyChat
//
//  Created by Tue Nguyen on 4/13/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import UIKit

protocol ActivityRepresentable {
    func beginActivity(_ message: String?)
    func endActivity(_ message: String?)
}

private var activityCountKey: UInt8 = 0

extension UIViewController: ActivityRepresentable {
    fileprivate var activityCount: Int {
        get {
            let number = associatedObject(self, key: &activityCountKey, initialiser: { () -> NSNumber in
                return NSNumber(value: 0 as Int32)
            })
            return number.intValue
        }
        set {
            associateObject(self, key: &activityCountKey, value: NSNumber(value: newValue as Int))
        }
    }
    func beginActivity(_ message: String?) {
        if activityCount == 0 {
            //HUD.show(.LabeledProgress(title: message, subtitle: nil))
        }
        
        activityCount += 1
        
    }
    
    func endActivity(_ message: String?) {
        if activityCount == 0 {
            return
        }
        
        activityCount -= 1
        if activityCount == 0 {
            //HUD.hide(animated: true)
        }
    }
}
//Demo use will need to remove
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        self.beginActivity("hello world!")
        
        Async.main(after: 2) {
            self.endActivity("Ended")
        }
        initObject()
        setupUI()
        loadBanner()
        registerNotificationObservers()
    }
    
    //MARK: Base functions
    func initObject(){
        
    }
    func loadBanner(){
    
    }
    func setupUI() {

    }
    func setupRightBarbutton(with viewType: ViewType, buttonBar: UIBarButtonItem){
        switch viewType {
        case .list:
            buttonBar.image = #imageLiteral(resourceName: "icon List view")
            break
        case .grid:
            buttonBar.image = #imageLiteral(resourceName: "Group")
            break
        }
    }
    func registerNotificationObservers() {
        
    }
    
    func unregisterNotificationObservers() {
        NotificationCenter.default.removeObserver(self);
    }
    
    func handleError(_ error:BaseError) {
        AppHelpers.showAlertMessage(AppInfo.appDisplayName(), content: error.errorMessage, fromViewcontroller: self, completion: nil)
    }
    
    func doClose() {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: NavigationItem
    
    func navigationBackItem(color: UIColor?) -> UIBarButtonItem {
        let image = UIImage(named: "iconBack")
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(doClose))
        var tintColor = color
        if tintColor == nil {
            tintColor = ColorSchema.mlkWhite()
        }
        barButton.tintColor = tintColor
        return barButton
    }
}
