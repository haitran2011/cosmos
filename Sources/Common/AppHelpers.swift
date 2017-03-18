//
//  AppHelpers.swift
//  ShopQuangChau
//
//  Created by Thanh Nguyen on 12/21/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

class AppHelpers {
    
    class func showAlertMessage(_ title:String, content:String, closeButton:String, fromViewcontroller:UIViewController, completion:(()->Void)?) {
        let alert:UIAlertController = UIAlertController(title: title, message: content, preferredStyle: .alert)
        let cancelAction:UIAlertAction = UIAlertAction(title: closeButton, style: .cancel, handler: {
            action in
            if completion != nil {
                completion!()
            }
        })
        alert.addAction(cancelAction)
        fromViewcontroller.present(alert, animated: true, completion: nil)
    }

    class func showAlertMessage(_ title:String, content:String, fromViewcontroller:UIViewController, completion:(()->Void)?) {
        AppHelpers.showAlertMessage(title, content: content, closeButton: "Dismiss".localized(), fromViewcontroller: fromViewcontroller, completion: completion)
    }
    
    class func changeRootViewController(_ newRootViewController:UIViewController, completion:(()->Void)?) {
        if AppDelegate.shareDelegate().window?.rootViewController != nil {
            UIView.transition(with: AppDelegate.shareDelegate().window!, duration: 0.5, options:[.transitionCrossDissolve, .allowAnimatedContent], animations: {
                let oldState = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                AppDelegate.shareDelegate().window?.rootViewController = newRootViewController
                UIView.setAnimationsEnabled(oldState)
                
            }, completion: { (success) in
                if completion != nil {
                    completion!()
                }
            })
        } else {
            AppDelegate.shareDelegate().window?.rootViewController = newRootViewController
            if completion != nil {
                completion!()
            }
        }
    }
    
    class func blockUI() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    class func unblockUI() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    class func heightForCell(_ videoDetail: VideoDetailItem?, width: CGFloat) -> CGFloat{
         let imageHeight = width * 37 / 64
        
        guard let video = videoDetail else{
            return imageHeight
        }
         let titleheight = video.title?.heightForLabel(withFont: UIFont.systemFont(ofSize: 15), availableWidth: width)
        guard let titleH = titleheight else {
            return imageHeight + 17*2 + 4*2
        }
      
      return imageHeight + titleH + 17*2 + 4*3
    }
    class func heightforPlayListCell(_ playlistItem: PlayListItem?, width: CGFloat) -> CGFloat{
        let imageHeight = width * 37 / 64
        guard let playlist = playlistItem else{
            return imageHeight
        }
        let titleHeight = playlist.title?.heightForLabel(withFont: UIFont.applicationFont(15), availableWidth: width)
        guard let titleH = titleHeight else {
            return imageHeight + 17 + 4
        }
        return imageHeight + titleH + 17 + 4*2
    }
}


