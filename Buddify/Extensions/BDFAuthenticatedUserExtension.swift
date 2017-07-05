//
//  BDFAuthenticatedUserExtension.swift
//  Buddify
//
//  Created by Tung Vo  on 22/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import Models

private let currentUserObjectKey = "dnbfanbmdvppadkjf"
private let currentUserPathComponent = "adhhajstyfahsd"

extension BDFAuthenticatedUser {
    public static var currentUser: BDFAuthenticatedUser {
        struct Singleton {
            static var user: BDFAuthenticatedUser =  BDFAuthenticatedUserArchiver.sharedInstance.retrieveUser(forKey: currentUserObjectKey, pathComponent: currentUserPathComponent)
        }
        
        return Singleton.user
    }
    
    ///
    /// Save user object
    ///
    func save() {
        // We can do this because there is only 1 authenticated user in the whole app.
        // This has to change if we support multiple logged in users
        
        // If we want to support multiple logged in users, each user needs to have its own object key 
        // and path component.
        BDFAuthenticatedUserArchiver.sharedInstance.saveUser(self, forKey: currentUserObjectKey, pathComponent: currentUserPathComponent)
    }
    
    func destroy() {
        // First remove the archive file
        BDFAuthenticatedUserArchiver.sharedInstance.saveUser(nil, forKey: currentUserObjectKey, pathComponent: currentUserPathComponent)
        
        // Then reset current user object
        self.updateInformation(BDFAuthenticatedUser())
    }
}