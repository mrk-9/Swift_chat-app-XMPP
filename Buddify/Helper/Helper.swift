//
//  Helper.swift
//  Buddify
//
//  Created by Vo Duc Tung on 29/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

func delay(seconds : Double, block : (() -> Void)) {
    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
        block()
    }
}
