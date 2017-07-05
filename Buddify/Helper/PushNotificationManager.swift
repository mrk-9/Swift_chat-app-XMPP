//
//  PushNotificationManager.swift
//  Buddify
//
//  Created by Vo Duc Tung on 19/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Whisper

class PushNotificationManager: NSObject {
    class func showPushNotification(pushNotification: PushNotification) {
        if pushNotification.type != .None &&  pushNotification.type != .Local {
            let murmur = Murmur(title: pushNotification.text)
            Whistle(murmur)
        }
    }
}
