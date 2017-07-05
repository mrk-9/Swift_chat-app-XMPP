//
//  Data.swift
//  Buddify
//
//  Created by Vo Duc Tung on 04/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

public class DTArchirverHelper : NSObject {
    var folderPath : String!
    
    /* Instance with folder path as caches directory which we are mainly using */
    static var cachesInstance : DTArchirverHelper {
        struct Singleton {
            static var instance : DTArchirverHelper!
        }
        
        if Singleton.instance == nil {
            Singleton.instance = DTArchirverHelper(folderPath: NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])
        }
        
        return Singleton.instance
    }
    
    ///
    /// Custom initializer
    ///
    public init(folderPath : String) {
        super.init()
        self.folderPath = folderPath
    }
    
    ///
    /// Helper method to get folder path.
    ///
    private func cachesDirectoryWithPathComponent(component : String) -> String {
        return (self.folderPath as NSString).stringByAppendingPathComponent(component)
    }
    
    public func saveObjectData(object : AnyObject?, forKey key : String, pathComponent : String) {
        let fileManager = NSFileManager.defaultManager()
        let path = self.cachesDirectoryWithPathComponent(pathComponent)
        
        if let _object = object {
            let data = NSMutableData()
            let archiver : NSKeyedArchiver = NSKeyedArchiver(forWritingWithMutableData: data)
            archiver.encodeObject(_object, forKey: key)
            archiver.finishEncoding()
            
            if !fileManager.fileExistsAtPath(self.folderPath, isDirectory: nil) {
                do {
                    try fileManager.createDirectoryAtPath(self.folderPath, withIntermediateDirectories: true, attributes: nil)
                } catch _ {
                    
                }
            }
            
            //Make app compatible with old version
            let success = data.writeToFile(path, atomically: true)
            
            if !success {
                
            }
            else {
                
            }
        }
        else {
            //Delete file
            let fileManager = NSFileManager.defaultManager()
            
            if fileManager.fileExistsAtPath(path) {
                do {
                    try fileManager.removeItemAtPath(path)
                } catch _ {
                    
                }
            }
        }
    }
    
    public func retrieveObjectForKey(key : String, pathComponent : String) -> AnyObject? {
        let path = self.cachesDirectoryWithPathComponent(pathComponent)
        if let data = NSData(contentsOfFile: path) {
            let unarchiver : NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            let object = unarchiver.decodeObjectForKey(key)
            unarchiver.finishDecoding()
            return object
        }
        return nil
    }
}
