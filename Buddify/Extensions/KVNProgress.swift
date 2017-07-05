//
//  KVNProgress.swift
//  Buddify
//
//  Created by Tung Vo  on 08/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import KVNProgress

extension KVNProgress {
    private static var _defaultConfigurationSet = false
    
    class func setDefaultConfiguration() {
        if !_defaultConfigurationSet {
            _defaultConfigurationSet = true
            
            let configuration = KVNProgressConfiguration()
            configuration.statusFont = UIFont.appFont(CGFloat.bigFontSize)
            configuration.statusColor = UIColor.appPurpleColor()
            configuration.circleStrokeBackgroundColor = UIColor.appPurpleColor().colorWithAlphaComponent(0.3)
            configuration.circleStrokeForegroundColor = UIColor.appPurpleColor()
            configuration.successColor = UIColor.appPurpleColor()
            configuration.errorColor = UIColor.appRedColor()
            configuration.minimumSuccessDisplayTime = 1.0
            configuration.minimumErrorDisplayTime = 2.0
            
            KVNProgress.setConfiguration(configuration)
        }
    }
}