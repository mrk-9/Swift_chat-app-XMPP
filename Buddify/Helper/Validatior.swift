//
//  Validatior.swift
//  Buddify
//
//  Created by Tung Vo  on 08/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

enum UsernameValidatorResult {
    case Valid
    case LessThanRequiredLegth
    case InvalidFirstChar
    case InvalidChar
}

class UsernameValidatior {
    let numberOfChars = 6
    
    func validateUsername(username: String) -> UsernameValidatorResult {
        if username.characters.count < numberOfChars {
            return UsernameValidatorResult.LessThanRequiredLegth
        }
        
        let letters = NSCharacterSet.letterCharacterSet()
        
        for uni in username.unicodeScalars {
            // Check first char
            if letters.longCharacterIsMember(uni.value) {
                break
            }
            else {
                return UsernameValidatorResult.InvalidFirstChar
            }
        }
        
        let invalidCharString = "abcdefghijklmnopqrstuvwxyz0123456789_."
        let invalidCharSet = NSCharacterSet.init(charactersInString: invalidCharString).invertedSet
        let range = username.rangeOfCharacterFromSet(invalidCharSet)
        
        if range == nil {
            return UsernameValidatorResult.Valid
            
        } else {
            return UsernameValidatorResult.InvalidChar
        }
    }
}