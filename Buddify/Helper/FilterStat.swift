//
//  FilterStat.swift
//  Buddify
//
//  Created by Vo Duc Tung on 03/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Models

private let kMinAgeKey = "kMinAgeKey"
private let kMaxAgeKey = "kMaxAgeKey"
private let kGenderKey = "kGenderKey"
private let kRadiusKey = "kRadiusKey"

class FilterStats: NSObject {
    class var sharedStats: FilterStats {
        struct Singleton {
            static var stats: FilterStats!
        }
        
        if Singleton.stats == nil {
            Singleton.stats = FilterStats()
            let userDefaults = NSUserDefaults.standardUserDefaults()
            
            Singleton.stats.minAge = userDefaults.integerForKey(kMinAgeKey)
            if Singleton.stats.minAge == 0 {
                Singleton.stats.minAge = 18
            }
            
            Singleton.stats.maxAge = userDefaults.integerForKey(kMaxAgeKey)
            if userDefaults.integerForKey(kMaxAgeKey) == 0 {
                Singleton.stats.maxAge = 45
            }
            
            let gender = userDefaults.integerForKey(kGenderKey) 
            Singleton.stats.gender = BDFUserGender(rawValue: gender) ?? BDFUserGender.Both
            
            if  Singleton.stats.gender == .None {
                Singleton.stats.gender = .Both
            }
            
            Singleton.stats.radius = userDefaults.integerForKey(kRadiusKey)
            if Singleton.stats.radius < 1 || Singleton.stats.radius > 200 {
                Singleton.stats.radius = 10
            }
        }
        
        return Singleton.stats
    }
    
    class func setMinAge(minAge: Int, maxAge: Int, genderSelection: BDFUserGender, radius: Int) {
        FilterStats.sharedStats.minAge = minAge
        FilterStats.sharedStats.maxAge = maxAge
        FilterStats.sharedStats.gender = genderSelection
        FilterStats.sharedStats.radius = radius
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(minAge, forKey: kMinAgeKey)
        userDefaults.setInteger(maxAge, forKey: kMaxAgeKey)
        userDefaults.setInteger(genderSelection.rawValue, forKey: kGenderKey)
        userDefaults.setInteger(radius, forKey: kRadiusKey)
        userDefaults.synchronize()
    }
    
    var minAge: Int!
    var maxAge: Int!
    var gender: BDFUserGender!
    
    // Radius in km
    var radius: Int!
}
