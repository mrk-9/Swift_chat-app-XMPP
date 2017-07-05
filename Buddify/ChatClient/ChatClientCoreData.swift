//
//  ChatClientCoreData.swift
//  Buddify
//
//  Created by Tung Vo  on 28/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import CoreData

class ChatClientCoreData: NSObject {
    var applicationDocumentsDirectory: NSURL {
        return NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
    }
    
    var _managedObjectModel: NSManagedObjectModel!
    var managedObjectModel: NSManagedObjectModel! {
        if _managedObjectModel != nil {
            return _managedObjectModel
        }
        
        let modelURL = NSBundle.mainBundle().URLForResource("ChatModel", withExtension: "momd")!
        _managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)
        
        return _managedObjectModel
    }
    
    var _persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator! {
        if _persistentStoreCoordinator != nil {
            return _persistentStoreCoordinator
        }
        
        let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ChatClient.sqlite")
        _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try _persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        }
        catch {
            fatalError("Persistent store error")
        }
        
        return _persistentStoreCoordinator
    }
    
    var _managedObjectContext: NSManagedObjectContext!
    var managedObjectContext: NSManagedObjectContext! {
        if _managedObjectContext != nil {
            return _managedObjectContext
        }
        else {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext.persistentStoreCoordinator = coordinator
                _managedObjectContext.mergePolicy = NSMergePolicy(mergeType: NSMergePolicyType.MergeByPropertyObjectTrumpMergePolicyType)
            }
        }
        
        return _managedObjectContext
    }
    
    private var _rosterManagedObjectContext: NSManagedObjectContext!
    var rosterManagedObjectContext: NSManagedObjectContext! {
        if _rosterManagedObjectContext != nil {
            return _rosterManagedObjectContext
        }
        else {
            let coordinator = self.persistentStoreCoordinator
            if coordinator != nil {
                _managedObjectContext = NSManagedObjectContext()
                _managedObjectContext.persistentStoreCoordinator = coordinator
                _managedObjectContext.mergePolicy = NSMergePolicy(mergeType: NSMergePolicyType.MergeByPropertyObjectTrumpMergePolicyType)
            }
        }
        
        return _managedObjectContext
    }
    
    
    func saveContext() {
        if managedObjectContext != nil {
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                }
                catch {
                    DTLog("Cannot save context")
                }
            }
        }
    }
    
    func _contextDidSave(notification: NSNotification) {
        if let savedContext = notification.object as? NSManagedObjectContext {
            if _managedObjectContext == savedContext {
                return
            }
            
            if _managedObjectContext.persistentStoreCoordinator != savedContext.persistentStoreCoordinator {
                return
            }
            
            //Update changes
            dispatch_async(dispatch_get_main_queue(), { 
                self._managedObjectContext.mergeChangesFromContextDidSaveNotification(notification)
            })
        }
    }
}
