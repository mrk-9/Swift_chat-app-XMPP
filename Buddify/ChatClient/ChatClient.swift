//
//  ChatClient.swift
//  Buddify
//
//  Created by Tung Vo  on 25/05/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import XMPPFramework
import Models
import CoreData
import Whisper

private let testAccount1 = true

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0 // Use this line in Xcode 7 or newer
        return TARGET_IPHONE_SIMULATOR != 0 // Use this line in Xcode 6
    }
    
}

// Notification keys
let BDFChatClientNewMessageNotificationKey = "BDFChatClientNewMessageNotificationKey"
let BDFChatClientChatStatusChangeNotificationKey = "BDFChatClientChatStatusChangeNotificationKey"

protocol BDFChatClient: class, NSObjectProtocol, XMPPRosterDelegate, XMPPStreamDelegate {
    init(config: BDFChatClientConfig)
    
    func addStreamDelegate(delegate: XMPPStreamDelegate, dispatchQueue: dispatch_queue_t)
    func removeStreamDelegate(delegate: XMPPStreamDelegate)
    func addRosterDelegate(delegate: XMPPRosterDelegate, dispatchQueue: dispatch_queue_t)
    func removeRosterDelegate(delegate: XMPPRosterDelegate)
    
    // Chat clients
    func startChattingWithUser(user: User)
    func stopChattingWithUser(user: User)
    func acceptChatRequestFromUser(user: User)
    func declineChatRequestFromUser(user: User)
    func sendChatRequestToUser(user: User)
    func blockUser(user: User)
    
    // Messages
    func sendMessageToUser(message: String, user: User)
    func sendImageToUser(image: UIImage, user: User)
    
    // Stream
    func connect() -> Bool
    func disconnect()
    func reconnect()
}

class ChatClient: NSObject, BDFChatClient {
    ///
    ///
    ///
    private var _fetchedResultsController: NSFetchedResultsController!
    
    ///
    /// Chat client core data
    ///
    private var _coreData: ChatClientCoreData!
    
    ///
    /// Roster managed object context
    ///
    private var _rosterManagedObjectContext: NSManagedObjectContext! {
        return _xmppRosterStorage.mainThreadManagedObjectContext
    }
    
    ///
    /// Managed object context
    ///
    var managedObjectContext: NSManagedObjectContext! {
        return _coreData.managedObjectContext
    }
    
    ///
    /// Required initializer
    ///
    var timeOutInterval: NSTimeInterval = 60
    private var _config: BDFChatClientConfig!
    
    ///
    ///
    ///
    private var _internalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
    
    ///
    /// Reconnect XEP
    ///
    private var _xmppReconnect: XMPPReconnect!
    
    ///
    /// XMPPvCardStorage
    ///
    private var _xmppvCardStorage: XMPPvCardCoreDataStorage!
    
    ///
    /// XMPPvCardTempModule
    ///
    private var _xmppvCardTempModule: XMPPvCardTempModule!
    
    ///
    /// XMPPvCardAvatarModule
    ///
    private var _xmppvCardAvatarModule: XMPPvCardAvatarModule!
    
    ///
    /// XMPPCapabilities
    ///
    private var _xmppCapabilities: XMPPCapabilities!
    
    ///
    /// XMPPCapabilities
    ///
    private var _xmppCapabilitiesStorage: XMPPCapabilitiesStorage!
    
    
    required init(config: BDFChatClientConfig) {
        super.init()
        _config = config
        
        // Initialize core data object
        _coreData = ChatClientCoreData()
        
        _xmppStream = XMPPStream()
        _xmppStream.enableBackgroundingOnSocket = true
        _xmppStream.addDelegate(self, delegateQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        self.timeOutInterval = config.timeOutInterval
        
        // Reconnect XEP
        _xmppReconnect = XMPPReconnect(dispatchQueue: _internalQueue)
        
        _xmppRosterStorage = XMPPRosterCoreDataStorage()
        _xmppRoster = XMPPRoster(rosterStorage: _xmppRosterStorage, dispatchQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        _xmppRoster.autoFetchRoster = true
        _xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = true
        _xmppRoster.addDelegate(self, delegateQueue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        
        // _xmppVCardStorage
        _xmppvCardStorage = XMPPvCardCoreDataStorage.sharedInstance()
        _xmppvCardTempModule = XMPPvCardTempModule(vCardStorage: _xmppvCardStorage)
        _xmppvCardAvatarModule = XMPPvCardAvatarModule(vCardTempModule: _xmppvCardTempModule)
        
        // Capabilities
        _xmppCapabilitiesStorage = XMPPCapabilitiesCoreDataStorage()
        _xmppCapabilities = XMPPCapabilities(capabilitiesStorage: _xmppCapabilitiesStorage)
        _xmppCapabilities.autoFetchHashedCapabilities = true
        _xmppCapabilities.autoFetchNonHashedCapabilities = false
        
        // Activate XMPP Modules
        _xmppRoster.activate(_xmppStream)
        _xmppReconnect.activate(_xmppStream)
        _xmppvCardTempModule.activate(_xmppStream)
        _xmppvCardAvatarModule.activate(_xmppStream)
        _xmppCapabilities.activate(_xmppStream)
    }
    
    func tearDownStream() {
        _xmppStream.removeDelegate(self)
        _xmppRoster.removeDelegate(self)
        
        _xmppRoster.deactivate()
        _xmppReconnect.deactivate()
        _xmppvCardTempModule.deactivate()
        _xmppvCardAvatarModule.deactivate()
        _xmppCapabilities.deactivate()
        
        _xmppStream.disconnect()
    }
    
    ///
    /// Singleton instance
    ///
    static var defaultClient: ChatClient {
        struct Singleton {
            static var client: ChatClient!
        }
        
        if Singleton.client == nil {
            let config = Platform.isSimulator ? ChatClientConfig(jid: "buddy1@chat.buddify.io", port: 5222, host: "chat.buddify.io", password: "buddy1") : ChatClientConfig(jid: "buddy2@chat.buddify.io", port: 5222, host: "chat.buddify.io", password: "buddy2")
            Singleton.client = ChatClient(config: config)
        }
        
        return Singleton.client
    }
    
    
    var _xmppRosterStorage: XMPPRosterCoreDataStorage!
    var _xmppRoster: XMPPRoster!
    
    ///
    /// XMPP Stream
    ///
    private(set) var _xmppStream: XMPPStream!
    
    
    func connect() -> Bool {
        if !_xmppStream.isDisconnected() {
            return true
        }
        
        _xmppStream.myJID = XMPPJID.jidWithString(_config.jid)
        _xmppStream.hostName = _config.host
        _xmppStream.hostPort = _config.port
        
        do {
            try _xmppStream.connectWithTimeout(self.timeOutInterval)
        }
        catch {
            return false
        }
        
        return true
    }
    
    func disconnect() {
        self.goOffline()
        _xmppStream.disconnect()
    }
    
    func reconnect() {
        
    }
    
    //Delegates
    func addStreamDelegate(delegate: XMPPStreamDelegate, dispatchQueue: dispatch_queue_t) {
        _xmppStream.addDelegate(delegate, delegateQueue: dispatchQueue)
    }
    
    func removeStreamDelegate(delegate: XMPPStreamDelegate) {
        _xmppStream.removeDelegate(delegate)
    }
    
    func addRosterDelegate(delegate: XMPPRosterDelegate, dispatchQueue: dispatch_queue_t) {
        _xmppRoster.addDelegate(delegate, delegateQueue: dispatchQueue)
    }
    
    func removeRosterDelegate(delegate: XMPPRosterDelegate) {
        _xmppRoster.removeDelegate(delegate)
    }
    
    // Add chat clients
    func sendInvitationToUser(user: User) {
        self.sendInvitationToJID(user.jid, nickName: user.name)
    }
    
    func acceptChatRequestFromUser(user: User) {
        _xmppRoster.acceptPresenceSubscriptionRequestFrom(self.jidFromUser(user), andAddToRoster: true)
    }
    
    func declineChatRequestFromUser(user: User) {
        _xmppRoster.rejectPresenceSubscriptionRequestFrom(self.jidFromUser(user))
    }
    
    func sendChatRequestToUser(user: User) {
        
    }
    
    func startChattingWithUser(user: User) {
        _xmppRoster.subscribePresenceToUser(self.jidFromUser(user))
    }
    
    func stopChattingWithUser(user: User) {
        _xmppRoster.unsubscribePresenceFromUser(self.jidFromUser(user))
    }
    
    func blockUser(user: User) {
        _xmppRoster.removeUser(self.jidFromUser(user))
    }
    
    func userWithJID(jid: String) -> XMPPUserCoreDataStorageObject {
        return _xmppRosterStorage.userForJID(XMPPJID.jidWithString(jid), xmppStream: _xmppStream, managedObjectContext: _rosterManagedObjectContext)
    }
    
    // Messages
    ///
    /// Send normal string message to a user
    ///
    func sendMessageToUser(message: String, user: User) {
        // If not same user
        if !_xmppStream.myJID.isEqualToJID(self.jidFromUser(user)) {
            let body = NSXMLElement(name: "body")
            body.setStringValue(message)
            
            let message = NSXMLElement(name: "message")
            message.addAttributeWithName("type", stringValue: "chat")
            message.addAttributeWithName("to", stringValue: user.jid)
            message.addChild(body)
            
            // Send message
            _xmppStream.sendElement(message)
        }
    }
    
    func sendImageToUser(image: UIImage, user: User) {
        
    }
    
    ///
    /// Send invitation to user
    ///
    func sendInvitationToJID(jidString: String, nickName: String) {
        let jid = XMPPJID.jidWithString(jidString)
        _xmppRoster.addUser(jid, withNickname: nickName)
        _xmppRoster.subscribePresenceToUser(jid)
    }
    
    func acceptChatRequestFromJID(jidString: String) {
        let jid = XMPPJID.jidWithString(jidString)
        _xmppRoster.acceptPresenceSubscriptionRequestFrom(jid, andAddToRoster: true)
    }
    
    /// Private methods
    private func jidFromUser(user: User) -> XMPPJID {
        return XMPPJID.jidWithString(user.jid)
    }
    
    private func goOnline() {
        let presence = XMPPPresence()
        let domain = _xmppStream.myJID.domain
        
        if domain == "gmail.com" || domain == "gtalk.com" || domain == "talk.google.com" {
            let priority = DDXMLElement.elementWithName("priority", stringValue: "24") as! DDXMLElement
            presence.addChild(priority)
        }
        
        _xmppStream.sendElement(presence)
    }
    
    private func goOffline() {
        let presence = XMPPPresence(name: "unavailable")
        _xmppStream.sendElement(presence)
    }
}

//MARK: XMPPStreamDelegate
extension ChatClient {
    func xmppStreamDidRegister(sender: XMPPStream!) {
        DTLog("Register a new user")
    }
    
    func xmppStream(sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        DTLog("Did not register with error \(error)")
    }
    
    func xmppStream(sender: XMPPStream!, socketDidConnect socket: GCDAsyncSocket!) {
        DTLog("Socket did connect")
        //CFReadStreamSetProperty(socket.readStream().takeRetainedValue(), kCFStreamNetworkServiceType, kCFStreamNetworkServiceTypeVoIP)
        //CFWriteStreamSetProperty(socket.writeStream().takeRetainedValue(), kCFStreamNetworkServiceType, kCFStreamNetworkServiceTypeVoIP)
    }
    
    func xmppStreamDidConnect(sender: XMPPStream!) {
        do {
            try sender.authenticateWithPassword(_config.password)
            DTLog("Connected")
        }
        catch {
            DTLog("Not authenticated")
        }
    }
    
    func xmppStreamDidDisconnect(sender: XMPPStream!, withError error: NSError!) {
        DTLog("Connect with error \(error.description)")
    }
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
        DTLog("Authenticated")
        self.goOnline()
    }
    
    func xmppStream(sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        DTLog("Did not authenticated")
    }
    
    func xmppStream(sender: XMPPStream!, didReceiveIQ iq: XMPPIQ!) -> Bool {
        DTLog("Did receive IQ")
        if let queryElement = iq.elementForName("query", xmlns: "jabber:iq:roster") {
            if let itemElements = queryElement.elementForName("item") {
                
            }
        }
        
        
        return false
    }
    
    func xmppStream(sender: XMPPStream!, didReceivePresence presence: XMPPPresence!) {
        DTLog("Did go online")
        
        if presence.isFrom(sender.myJID) {
            delay(1.0) {
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.dynamicType.test_sendMessage), userInfo: nil, repeats: true)
            }
        }
        else {
            // Do something here
            
        }
    }
    
    ///
    /// Test send message
    ///
    func test_sendMessage() {
//        let user = BDFAuthenticatedUser()
//        user.jid = Platform.isSimulator ? "buddy2@chat.buddify.io" : "buddy1@chat.buddify.io"
//        self.sendMessageToUser("Fuck you!!", user: user)
    }
    
    func xmppStream(sender: XMPPStream!, didSendMessage message: XMPPMessage!) {
        //DTLog("Message sent")
    }
    
    func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
        // If not current user
        if !message.isFrom(sender.myJID) {
            // Chat message
            if message.isChatMessageWithBody() {
                // Get user
                //let user = _xmppRosterStorage.userForJID(message.from(), xmppStream: _xmppStream, managedObjectContext: _rosterManagedObjectContext)
                let body = message.body()
                let username = "tungvoduc" //user.displayName
                
                if UIApplication.sharedApplication().applicationState == UIApplicationState.Active {
                    DTLog("tungvoduc sent you a message: \(body)")
                }
                else {
                    let localNotification = UILocalNotification()
                    localNotification.alertBody = "\(username): \(body)"
                    localNotification.soundName = UILocalNotificationDefaultSoundName
                    UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
                }
                
                // Save message
                self.updateCoreDataWithIncommingMessage(message)
            }
            // Typing status
            else if message.isChatMessage() {
                if let elements = message.elementsForXmlns("http://jabber.org/protocol/chatstates") as? [NSXMLElement] {
                    if elements.count > 0 {
                        for element in elements {
                            var statusString = " "
                            let cleanStatus = element.name().stringByReplacingOccurrencesOfString("cha:", withString: "")
                            
                            if cleanStatus == "composing" {
                                statusString = " is typing"
                            }
                            else if cleanStatus == "active" {
                                statusString = " is ready"
                            }
                            else if cleanStatus == "paused" {
                                statusString = " is pausing"
                            }
                            else if cleanStatus == "inactive" {
                                statusString = "is not active"
                            }
                            else if cleanStatus == "gone" {
                                statusString = " left this chat"
                            }
                            
                            let dictionary = ["msg": statusString]
                            
                            // Chat status change notification
                            NSNotificationCenter.defaultCenter().postNotificationName(BDFChatClientChatStatusChangeNotificationKey, object: self, userInfo: dictionary)
                        }
                    }
                }
            }
        }
    }
    
    func xmppStream(sender: XMPPStream!, willSecureWithSettings settings: NSMutableDictionary!) {
        
    }
    
    func xmppStreamDidSecure(sender: XMPPStream!) {
        
    }
    
    func xmppStream(sender: XMPPStream!, didReceiveError error: DDXMLElement!) {
        
    }
}

// XMPPRosterDelegate
extension ChatClient: XMPPRosterDelegate {
    func xmppRoster(sender: XMPPRoster!, didReceivePresenceSubscriptionRequest presence: XMPPPresence!) {
        let user = _xmppRosterStorage.userForJID(presence.from(), xmppStream: _xmppStream, managedObjectContext: _rosterManagedObjectContext)
        let name = user.displayName
        
        _xmppRoster.acceptPresenceSubscriptionRequestFrom(presence.from(), andAddToRoster: true)
        
        if UIApplication.sharedApplication().applicationState == UIApplicationState.Active {
            
        }
        else {
            //Display notification
            let localNotification = UILocalNotification()
            localNotification.alertBody = "\(name) sent you a message request."
            localNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
        }
        
        do {
            try _rosterManagedObjectContext.save()
        }
        catch {
            DTLog("Cannot save roster context")
        }
    }
    
    func xmppRoster(sender: XMPPRoster!, didReceiveRosterItem item: DDXMLElement!) {
        DTLog(item)
        DTLog("Receive roster")
    }
    
    func xmppRosterDidEndPopulating(sender: XMPPRoster!) {
        let jidList = _xmppRosterStorage?.jidsForXMPPStream(_xmppStream)
        print("List=\(jidList)")
    }
}


// Contacts list
private let userEntityString = "XMPPUserCoreDataStorageObject"

extension ChatClient: NSFetchedResultsControllerDelegate {
    var fetchedResultsController: NSFetchedResultsController! {
        if _fetchedResultsController == nil {
            let entity = NSEntityDescription.entityForName(userEntityString, inManagedObjectContext: _rosterManagedObjectContext)
            
            let sortDescriptor1 = NSSortDescriptor(key: "sectionNum", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "displayName", ascending: true)
            
            let sortDescriptors = [sortDescriptor1, sortDescriptor2]
            
            
            let fetchRequest = NSFetchRequest(entityName: userEntityString)
            fetchRequest.entity = entity
            fetchRequest.sortDescriptors = sortDescriptors
            fetchRequest.fetchBatchSize = 10
            
            _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: _rosterManagedObjectContext, sectionNameKeyPath: "sectionNum", cacheName: nil)
            _fetchedResultsController.delegate = self
            
            do {
                try _fetchedResultsController.performFetch()
            }
            catch {
                DTLog("Fetching error")
            }
            
        }
        return _fetchedResultsController
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    ///
    /// Get number of new message from a conversation
    ///
    func numberOfNewMessagesFromJID(jid: String) -> Int {
        var number = 0
        let entity = NSEntityDescription.entityForName(userEntityString, inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        let predicate = NSPredicate(format: "jidString == %@", jid)
        
        fetchRequest.predicate = predicate
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "messageDate", ascending: false)
        let sortDescriptors: [NSSortDescriptor] = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let chats = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Chat] {
                for chat in chats {
                    if chat.isNew == true {
                        number += 1
                    }
                }
            }
        }
        catch {
            
        }
        
        return number
    }
    
    ///
    /// Get lastest chat record from a conversation
    ///
    func latestChatRecordFromJID(jid: String) -> Chat? {
        var latestChat: Chat?
        
        let entity = NSEntityDescription.entityForName("Chat", inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        let predicate = NSPredicate(format: "jidString == %@", jid)
        
        fetchRequest.predicate = predicate
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "messageDate", ascending: false)
        let sortDescriptors: [NSSortDescriptor] = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let chats = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Chat] {
                if chats.count > 0 {
                    latestChat = chats[0]
                }
                
                for chat in chats {
                    DTLog(chat.jidString)
                }
            }
        }
        catch {
            
        }
        
        // Return latest chat
        return latestChat
    }
    
//    func latestChatRecordFromJID(jid: String) -> Chat? {
//        var latestChat: Chat?
//        
//        let entity = NSEntityDescription.entityForName(userEntityString, inManagedObjectContext: _rosterManagedObjectContext)
//        let fetchRequest = NSFetchRequest()
//        let predicate = NSPredicate(format: "jidString == %@", jid)
//        
//        //fetchRequest.predicate = predicate
//        fetchRequest.entity = entity
//        
//        let sortDescriptor = NSSortDescriptor(key: "messageDate", ascending: false)
//        let sortDescriptors: [NSSortDescriptor] = [sortDescriptor]
//        fetchRequest.sortDescriptors = sortDescriptors
//        
//        do {
//            if let chats = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Chat] {
//                if chats.count > 0 {
//                    latestChat = chats[0]
//                }
//                
//                for chat in chats {
//                    DTLog(chat.jidString)
//                }
//            }
//        }
//        catch {
//            
//        }
//        
//        // Return latest chat
//        return latestChat
//    }
    
    ///
    /// Get latest chat records from a conversation
    ///
    func chatsFromJID(jid: String) -> [Chat]? {
        let entity = NSEntityDescription.entityForName(userEntityString, inManagedObjectContext: managedObjectContext)
        let fetchRequest = NSFetchRequest()
        let predicate = NSPredicate(format: "jidString == %@", jid)
        
        fetchRequest.predicate = predicate
        fetchRequest.entity = entity
        
        let sortDescriptor = NSSortDescriptor(key: "messageDate", ascending: false)
        let sortDescriptors: [NSSortDescriptor] = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            if let chats = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [Chat] {
                return chats
            }
        }
        catch {
            
        }
        
        // Return latest chat
        return nil
    }
    
    ///
    /// Get profile picture from a user
    ///
    func imageFromUser(user: XMPPUserCoreDataStorageObject) -> UIImage? {
        if user.photo != nil {
            return user.photo
        }
        else {
            if let photoData = _xmppvCardAvatarModule.photoDataForJID(user.jid) {
                return UIImage(data: photoData)
            }
        }
        
        return nil
    }
    
    ///
    /// Get profile picture from a JID
    ///
    func imageFromJIDString(jid: String) -> UIImage? {
        let user = self.userWithJID(jid)
        return self.imageFromUser(user)
    }
    
    ///
    /// Get profile picture from a JID
    ///
    func nameFromJIDString(jid: String) -> String {
        let user = self.userWithJID(jid)
        if user.displayName == nil {
            return "Tung Vo Duc"
        }
        
        return user.displayName
    }
    
    ///
    /// Delete the whole conversation
    ///
    func deleteConversationWithJID(jid: String) {
        let entity = NSEntityDescription.entityForName("Chat", inManagedObjectContext: self.managedObjectContext)
        let fetchRequest = NSFetchRequest()
        let predicate = NSPredicate(format: "jidString == %@", jid)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        
        do {
            if let fetchedObjects = try self.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                // Just get all chats at the moment
                for object in fetchedObjects {
                    self.managedObjectContext.deleteObject(object)
                }
                
                do {
                    try self.managedObjectContext.save()
                    
                }
                catch {
                    
                }
            }
        }
        catch {
            abort()
        }
    }
}

///
/// Extension for core data
///
extension ChatClient {
    func updateCoreDataWithIncommingMessage(message: XMPPMessage) {
        let user = _xmppRosterStorage.userForJID(message.from(), xmppStream: _xmppStream, managedObjectContext: managedObjectContext)
        let chat: Chat = NSEntityDescription.insertNewObjectForEntityForName("Chat", inManagedObjectContext: self.managedObjectContext) as! Chat
        chat.messageBody = message.body()
        chat.messageDate = NSDate()
        chat.messageStatus = "received"
        chat.direction = "in"
        chat.isNew = NSNumber(bool: true)
        chat.hasMedia = NSNumber(bool: false)
        chat.isGroupMessage = NSNumber(bool: false)
        chat.jidString = message.fromStr()
        chat.groupNumber = ""
        
        do {
            try self.managedObjectContext.save()
            DTLog("Context saved")
        }
        catch {
            DTLog("Saving has error")
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(BDFChatClientNewMessageNotificationKey, object: self, userInfo: nil)
    }
}


