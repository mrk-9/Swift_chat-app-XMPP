//
//  ChatClientConfig.swift
//  Buddify
//
//  Created by Tung Vo  on 25/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

protocol BDFChatClientConfig: class, NSObjectProtocol {
    init(jid: String, port: UInt16, host: String, password: String)
    
    var jid: String! {get set}
    var port: UInt16 {get set}
    var host: String {get set}
    var password: String {get set}
    var timeOutInterval: NSTimeInterval {get set}
}

class ChatClientConfig: NSObject, BDFChatClientConfig {
    var jid: String!
    var port: UInt16
    var host: String
    var timeOutInterval: NSTimeInterval = 60
    var password: String
    
    required init(jid: String, port portName: UInt16, host hostName: String, password pass: String) {
        port = portName
        host = hostName
        password = pass
        super.init()
        self.jid = jid
    }
}