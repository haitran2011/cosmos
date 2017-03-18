//
//  SettingManager.swift
//  cosmos
//
//  Created by Tue Nguyen on 6/14/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
class SettingManager {
    fileprivate static var setting = SettingManager()
    var searchType = SearchType.video
    var orderSearchType = OrderSearchType.date
    var enableRotateScreen = false
    
    class func currentSetting() -> SettingManager {
        return setting
    }
    
}
