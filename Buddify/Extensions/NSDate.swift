//
//  NSDate.swift
//  Buddify
//
//  Created by Vo Duc Tung on 30/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AFDateHelper

extension NSDate {
    var age: Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
    }
	var birthdayString: String {
		let dateMakerFormatter = NSDateFormatter()
		dateMakerFormatter.dateFormat = "dd-MM-yyyy"
		return 	dateMakerFormatter.stringFromDate(self)

	}
    
    class func calculateAge (birthday: NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.Year, fromDate: birthday, toDate: NSDate(), options: []).year
    }
    
    func toDefaultString() -> String {
        if self.isToday() {
            return "Today, " + toString(dateStyle: .NoStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        }
        else if self.isYesterday() {
            return "Yesterday, " + toString(dateStyle: .NoStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        }
        else if (self.weekday() > NSDate().weekday() && self.isLastWeek()) || self.isThisWeek() {
            return self.weekdayToString() + ", " + toString(dateStyle: .NoStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        }
        else {
            return toString(dateStyle: .MediumStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: false)
        }
    }
    
    func toShortDefaultString() -> String {
        if self.isToday() {
            return toString(dateStyle: .NoStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        }
        else if self.isYesterday() {
            return "Yesterday, " + toString(dateStyle: .NoStyle, timeStyle: .ShortStyle, doesRelativeDateFormatting: false)
        }
        else {
            return toString(dateStyle: .MediumStyle, timeStyle: .NoStyle, doesRelativeDateFormatting: false)
        }
    }
    
    func toDefaultRelativeString() -> String {
        let timeInterval = Int(NSDate().timeIntervalSinceDate(self))
        if timeInterval == 0{
            return NSLocalizedString("Just now", comment: "")
        }
        else if timeInterval < 60 {
            //In seconds
            return String.textFromNumber(timeInterval, singularText: " second ago", pluralText: " seconds ago")
        }
        else if timeInterval < 3600{
            //In minutes
            return String.textFromNumber(timeInterval/60, singularText: " minute ago", pluralText: " minutes ago")
            //return "\(timeInterval/60)m"
        }
        else if timeInterval < 3600 * 24 {
            //In hours
            return String.textFromNumber(timeInterval/3600, singularText: " hour ago", pluralText: " hours ago")
            //return "\(timeInterval / 3600)h"
        }
        else if timeInterval < 3600 * 24 * 7{
            //In days
            return String.textFromNumber(timeInterval/(3600*24), singularText: " day ago", pluralText: " days ago")
            //return "\(timeInterval / (3600 * 24))d"
        }
        else if timeInterval < 3600 * 24 * 365 {
            //In weeks
            return String.textFromNumber(timeInterval/(3600*24*7), singularText: " week ago", pluralText: " weeks ago")
            //return "\(timeInterval / (3600 * 24 * 7))w"
        }
        else{
            //In years
            return String.textFromNumber(timeInterval/(3600*24*365), singularText: " year ago", pluralText: " years ago")
            //return "\(timeInterval / (3600 * 24 * 365))y"
        }
    }
    
    func toDefaultRelativeShortString() -> String {
        let timeInterval = Int(NSDate().timeIntervalSinceDate(self))
        if timeInterval == 0{
            return NSLocalizedString("Just now", comment: "")
        }
        else if timeInterval < 60 {
            //In seconds
            return "\(timeInterval)s"
        }
        else if timeInterval < 3600{
            //In minutes
            return "\(timeInterval/60)m"
        }
        else if timeInterval < 3600 * 24 {
            //In hours
            return "\(timeInterval / 3600)h"
        }
        else if timeInterval < 3600 * 24 * 7{
            //In days
            return "\(timeInterval / (3600 * 24))d"
        }
        else if timeInterval < 3600 * 24 * 365 {
            //In weeks
            return "\(timeInterval / (3600 * 24 * 7))w"
        }
        else{
            //In years
            return "\(timeInterval / (3600 * 24 * 365))y"
        }
    }
}
