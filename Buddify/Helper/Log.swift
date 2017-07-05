//
//  Log.swift
//  Buddify
//
//  Created by Vo Duc Tung on 09/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

private var debugMode = true

func DTLog(items: Any) {
    if debugMode {
        print(items, terminator: "")
    }
}