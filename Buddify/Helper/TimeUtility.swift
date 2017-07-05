//
//  TimeUtility.swift
//  Dispot
//
//  Created by Tung Vo on 20/02/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

class TimeUtility: NSObject {
    var timeFormatter : NSDateFormatter!
    
    class var sharedInstance : TimeUtility!{
        get {
            struct Static {
                static var instance : TimeUtility!
            }
            
            if Static.instance == nil {
                Static.instance = TimeUtility()
            }
            
            return Static.instance!
        }
    }
    
    override init() {
        super.init()
        timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZZZ"
    }
    
    func dateFromString(string : String!) -> NSDate?{
        let date = timeFormatter.dateFromString(string)
        return date
    }
    
    func customDateFromString(string : String!) -> Date? {
        var date = Date()
        if let _date = TimeUtility.sharedInstance.dateFromString(string) {
            let calendar = NSCalendar.currentCalendar()
            let dateComponent = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: _date)
            date.day = dateComponent.day
            date.month = dateComponent.month
            date.year = dateComponent.year
        }
        return date
    }
    
    func customDateFromDate(date : NSDate) -> Date? {
        var customDate = Date()
        let calendar = NSCalendar.currentCalendar()
        let dateComponent = calendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: date)
        customDate.day = dateComponent.day
        customDate.month = dateComponent.month
        customDate.year = dateComponent.year
        return customDate
    }
    
    func timeDifferenceFromDate(oldDate : NSDate?) -> NSTimeInterval{
        if let date = oldDate {
            return NSDate().timeIntervalSinceDate(date)
        }
        return 0
    }
    
    func timeDifferenceStringWithDate(oldDate : NSDate?) -> String {
        return self.stringFromTimeDifference(self.timeDifferenceFromDate(oldDate))
    }
    
    func stringFromTimeDifference(timeInterval : NSTimeInterval) -> String{
        if timeInterval == 0{
            return NSLocalizedString("now", comment: "")
        }
        else if timeInterval < 60 {
            //In seconds
            return "\(Int(timeInterval))s"
        }
        else if timeInterval < 3600{
            //In minutes
            return "\(Int(timeInterval / 60))m"
        }
        else if timeInterval < 3600 * 24 {
            //In hours
            return "\(Int(timeInterval / 3600))h"
        }
        else if timeInterval < 3600 * 24 * 7{
            //In days
            return "\(Int(timeInterval / (3600 * 24)))d"
        }
        else if timeInterval < 3600 * 24 * 365 {
            //In weeks
            return "\(Int(timeInterval / (3600 * 24 * 7)))w"
        }
        else{
            //In years
            return "\(Int(timeInterval / (3600 * 24 * 365)))y"
        }
    }
    
    class func stringFromTimeString(string : String!) -> String{
        let sharedInstance = TimeUtility.sharedInstance
        let date = sharedInstance.dateFromString(string)
        let timeDifference = sharedInstance.timeDifferenceFromDate(date)
        return sharedInstance.stringFromTimeDifference(timeDifference)
    }
}

struct Date {
    var day : Int!
    var month : Int!
    var year : Int!
    
    init() {
       day = 1
        month = 1
        year = 2015
    }
    
    func monthString() -> String {
        let monthString : String
        switch month {
        case 1:
            monthString = "JAN"
        case 2:
            monthString = "FEB"
        case 3:
            monthString = "MAR"
        case 4:
            monthString = "APR"
        case 5:
            monthString = "MAY"
        case 6:
            monthString = "JUN"
        case 7:
            monthString = "JUL"
        case 8:
            monthString = "AUG"
        case 9:
            monthString = "SEP"
        case 10:
            monthString = "OCT"
        case 11:
            monthString = "NOV"
        case 12:
            monthString = "DEC"
        default:
            monthString = ""
        }
        
        return monthString.uppercaseString
    }
}
