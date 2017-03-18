//
//  Font.swift
//  cosmos
//
//  Created by Tue Nguyen on 4/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    class func applicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    class func boldApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func mediumAppicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func lightApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    class func italicApplicationFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Italic", size: size)!
    }
    
    class func ubuntuMediumFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Ubuntu-Medium", size: size)!
    }
    
    class func notosansFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans", size: size)!
    }
    
    //    class func notosansMediumFont(_ size: CGFloat) -> UIFont {
    //        return UIFont(name: "NotoSans-Medium", size: size)!
    //    }
    class func notosansBoldFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "NotoSans-Bold", size: size)!
    }
    
    
    class func robotoLightFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size)!
    }
}
