//
//  GlobalFunctions.swift
//  Buddify
//
//  Created by Tung Vo  on 08/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

func dispatch_async_main_queue(block: dispatch_block_t) {
    dispatch_async(dispatch_get_main_queue(), block)
}