//
//  Helper.swift
//  Models
//
//  Created by Tung Vo  on 04/06/16.
//  Copyright © 2016 Tung Vo . All rights reserved.
//

import Foundation

class Helper {
    ///
    /// Static date formatter
    ///
    static var dateFormatter: NSDateFormatter {
        struct Singleton {
            static var formatter: NSDateFormatter!
        }
        
        if Singleton.formatter == nil {
            Singleton.formatter = NSDateFormatter()
            Singleton.formatter.dateFormat = "YYYY-MM-dd"
        }
        
        return Singleton.formatter
    }
    
    ///
    /// Calendar.
    /// Used to calculate age.
    ///
    static var calendar: NSCalendar = NSCalendar.currentCalendar()
    
    // Helper method to calculate age from birthdate
    class func calculateAge(birthdate: NSDate) -> Int {
        let ageComponents = Helper.calendar.components(NSCalendarUnit.Year, fromDate: birthdate, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))
        return ageComponents.year
    }
    
    class func stringFromDate(date: NSDate) -> String {
        return Helper.dateFormatter.stringFromDate(date)
    }
}