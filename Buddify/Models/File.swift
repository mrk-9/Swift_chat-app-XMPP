//
//  File.swift
//  Buddify
//
//  Created by Admin on 14/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

enum DTContentStatus {
    case NotLoaded // If content has not been loaded
    case Loaded // Content has been loaded
    case NoContent // Loaded but there is empty content
    case ErrorLoad // Loaded but error
}