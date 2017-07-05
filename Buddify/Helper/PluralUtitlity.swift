//
//  PluralUtitlity.swift
//  Dispot
//
//  Created by Tung Vo on 25/02/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//


extension String {
    static func textFromNumber(number : Int, singularText: String!, pluralText: String!) -> String!{
        if number == 1 {
            return String(number) + singularText
        }
        else{
            return String(number) + pluralText
        }
    }
    
    static func modifiedTextFromNumber(number : Int?, singularText: String!, pluralText : String!) -> String!{
        if number == nil {
            return pluralText
        }
        else{
            if number == 1 {
                return "\(number!)" + " " + singularText
            }
            else{
                if number < 1000 {
                    return String(format: "%d", number!) + " " + pluralText
                }
                else if number < 10000 {
                    let float = Double(number!)/1000
                    if float%1 >= 0.5 {
                        return  String(format: "%.1fK", float) + " " + pluralText
                    }
                    return  String(format: "%dK", Int(float)) + " " + pluralText
                }
                else if number < 1000000 {
                    return  String(format: "%dK", number!/1000) + " " + pluralText
                }
                else{
                    let float = Double(number!)/1000000
                    return  String(format: "%.1fM", float) + " " + pluralText
                }
            }
        }
    }
}