//
//  AuthenticatedUserArchiver.swift
//  Buddify
//
//  Created by Tung Vo  on 22/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import Models

class BDFAuthenticatedUserArchiver: DTArchirverHelper {
    static var sharedInstance: BDFAuthenticatedUserArchiver {
        struct Singleton {
            static var archiver = BDFAuthenticatedUserArchiver(folderPath: DTArchirverHelper.cachesInstance.folderPath)
        }
        
        return Singleton.archiver
    }
    
    func saveUser(user: BDFAuthenticatedUser?, forKey key: String, pathComponent : String) {
        self.saveObjectData(user, forKey: key, pathComponent: pathComponent)
    }
    
    func retrieveUser(forKey key: String, pathComponent : String) -> BDFAuthenticatedUser {
        return self.retrieveObjectForKey(key, pathComponent: pathComponent) as? BDFAuthenticatedUser ?? BDFAuthenticatedUser()
    }
}