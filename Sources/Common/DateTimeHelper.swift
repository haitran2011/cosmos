//
//  DateTimeHelper.swift
//  MilkyChat
//
//  Created by tienle on 1/23/17.
//  Copyright © 2017 Savvycom. All rights reserved.
//

import Foundation

class DateTimeHelper {
    
    class func applicationDateFormat() -> String {
        return "dd/MM/yyyy"
    }
    
    class func relativePast(for date : Date) -> String {
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
        let components = Calendar.current.dateComponents(units, from: date, to: Date())
        
        if components.year! > 0 {
            return "\(components.year!) " + (components.year! > 1 ? "Năm trước" : "Năm trước")
            
        } else if components.month! > 0 {
            print("month =\(components.month!)")
            return "\(components.month!) " + (components.month! > 1 ? "Tháng trước" : "Tháng trước")
            
        } else if components.weekOfYear! > 0 {
            return "\(components.weekOfYear!) " + (components.weekOfYear! > 1 ? "Tuần trước" : "Tuần trước")
            
        } else if (components.day! > 0) {
            return (components.day! > 1 ? "\(components.day!) Ngày trước" : "Hôm qua")
            
        } else if components.hour! > 0 {
            return "\(components.hour!) " + (components.hour! > 1 ? "Giờ trước" : "Giờ trước")
            
        } else if components.minute! > 0 {
            return "\(components.minute!) " + (components.minute! > 1 ? "Phút trước" : "Phút trước")
            
        } else {
            return "\(components.second!) " + (components.second! > 1 ? "Giây trước" : "Giây trước")
        }
    }
    
    class func stringToDate(dateString : String?, formaterString: String?) -> Date {
        if dateString != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formaterString
            
            let myDate = dateFormatter.date(from: dateString!)!
            
            return myDate
        } else {
            let myDate = Date()
            return myDate
        }
    }
    
    class func dateToString(aDate: Date?, formaterString: String?) -> String {
        if (aDate != nil) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = formaterString
            
            let myDate: Date = aDate!
            let dateObj: String = dateFormatter.string(from:myDate)
            
            return dateObj
        } else {
            return ""
        }
    }
    
    class func doubleToHour(_ duration: Double) -> String {
        
        let duration_minutes : Double = floor(duration/60)
        let duration_seconds : Double = duration - (duration_minutes * 60)
        
        
        let timeString = String(format: "%0.2f:%0.2f", duration_minutes, duration_seconds)
        
        return timeString
    }
    
    class func doubleToTimePlay(currentTime: Double, duration:Double) -> String {
        let current_minutes : Double = floor(currentTime/60)
        let current_seconds : Double = currentTime - (current_minutes * 60)
        
        let duration_minutes : Double = floor(duration/60)
        let duration_seconds : Double = duration - (duration_minutes * 60)
        
        var cmString : String = "\(current_minutes)"
        var csString : String = "\(current_seconds)"
        if current_minutes < 10 {
            cmString = "0\(current_minutes)"
        }
        
        if current_seconds < 10 {
            csString = "0\(current_seconds)"
        }
        
        var dmString : String = "\(duration_minutes)"
        var dsString : String = "\(duration_seconds)"
        if duration_minutes < 10 {
            dmString = "0\(duration_minutes)"
        }
        
        if duration_seconds < 10 {
            dsString = "0\(duration_seconds)"
        }
        
        let timeString = String(format: "%@:%@ / %@:%@ ", csString, cmString, dsString, dmString)
        
        return timeString
    }
    
    class func countdownTimePlay(time: Double, duration: Double) -> String {
        let countdown : Double = ceil(duration) - ceil(time)
        
        let countdown_minutes : Double = floor(countdown/60)
        let countdown_seconds : Double = ceil( countdown - (countdown_minutes * 60) )
        
        var cmString : String = String(format: "%d", Int(countdown_minutes))
        var csString : String = String(format: "%d", Int(countdown_seconds))
        
        if countdown_minutes < 10 {
            cmString = String(format: "0%d", Int(countdown_minutes))
        }
        
        if countdown_seconds < 10 {
            csString = String(format: "0%d", Int(countdown_seconds))
        }
        
        let timeString = String(format: "%@:%@", cmString, csString)
        
        return timeString
    }
}
