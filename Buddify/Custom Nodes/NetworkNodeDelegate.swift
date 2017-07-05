//
//  NetworkNodeDelegate.swift
//  Buddify
//
//  Created by Vo Duc Tung on 01/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

///
/// Protocol for all nodes which has loading network images e.g. profile photo, post images
///
@objc protocol NetworkNodeDelegate: NSObjectProtocol {
    ///
    /// This function is where you put all static data loading
    /// e.g: set number of likes, set number of comments, name, age, etc.
    ///
    func loadStaticData(data: AnyObject?)
    
    ///
    /// This function is where you put all network data loading
    /// e.g: set profile image, post image, etc.
    func loadNetworkingData(data: AnyObject?)
}

///
/// Protocol for all data source that provide loading network data.
///
@objc protocol NetworkDataSource: NSObjectProtocol {
    var currentLoadedIndexPath: NSIndexPath! {get set}
}