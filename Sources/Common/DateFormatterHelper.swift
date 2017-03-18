//
//  DateFormaterHelper.swift
//  MilkyChat
//
//  Created by Thanh Nguyen on 12/27/16.
//  Copyright © 2016 Savvycom. All rights reserved.
//

import Foundation
import SwiftDate

class DateFormatterHelper {
    
    class func changeColloquial(_ colloquial: String) -> String {
        var result = colloquial
        result = colloquial.replace("minute", withString: "min")
        if result != colloquial {
            return result
        }
        result = colloquial.replace("hour", withString: "hr")
        result = result.replace("one", withString: "1")
        result = result.replace("One", withString: "1")
        
        return result
    }
    
    class func dateStringInTimeline(_ date:DateInRegion) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day,Calendar.Component.year], from: date.absoluteDate, to: Date())
        if components.day! < 2 {
            var (colloquial, _) = try! date.colloquialSinceNow()
            colloquial = changeColloquial(colloquial)
            colloquial = colloquial.capitalizingFirstLetter()
            if components.day! < 1 { //To day
                return colloquial
            } else {                   // Yesterday
                let timeStr = date.string(custom: " • hh:mm a") //
                return colloquial.appending(timeStr)
            }
        }
        if components.day! < 7 { //Previous days up to 1 week
            return date.string(custom: "EEE • hh:mm a") //
        }
        if components.year! < 1 {
            return date.string(custom: "dd MMM • hh:mm a") //
        }
        
        let str = date.string(custom: "yyyy-MM-dd • hh:mm a") //
        return str
    }
    
    class func dateStringInMessage(_ date:DateInRegion) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: date.absoluteDate, to: Date())
        if components.day! < 1 {
            return date.string(custom: "hh:mm a") //
        }
        
        let str = date.string(custom: "yyyy-MM-dd") //
        return str
    }
    
}
