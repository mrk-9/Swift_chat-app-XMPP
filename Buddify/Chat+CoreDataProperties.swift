//
//  Chat+CoreDataProperties.swift
//  Buddify
//
//  Created by Tung Vo  on 29/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Chat {

    @NSManaged var direction: String?
    @NSManaged var filenameAsSent: String?
    @NSManaged var roomName: String?
    @NSManaged var roomJID: String?
    @NSManaged var mimeType: String?
    @NSManaged var messageStatus: String?
    @NSManaged var messageDate: NSDate?
    @NSManaged var messageBody: String?
    @NSManaged var mediaType: String?
    @NSManaged var localfileName: String?
    @NSManaged var jidString: String?
    @NSManaged var isNew: NSNumber?
    @NSManaged var isGroupMessage: NSNumber?
    @NSManaged var hasMedia: NSNumber?
    @NSManaged var groupNumber: String?

}
