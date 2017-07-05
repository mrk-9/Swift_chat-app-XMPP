//
//  ConversationsViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 10/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

private let kNewMessageIconSize: CGFloat = 20


class ConversationsViewController: ASViewController, SearchViewControllerDelegate, TabbarItemDelegate {
    private var _dataSource: ConversationDataSource!
    var tableNode: ASTableNode!
    
    init() {
        tableNode = ASTableNode()
        super.init(node: tableNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Conversations", comment: "")
        tableNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        tableNode.view.contentMode = UIViewContentMode.ScaleToFill
        tableNode.view.alwaysBounceVertical = true
        tableNode.view.rowHeight = 60
        
        _dataSource = ConversationDataSource(tableNode: tableNode, viewController: self)

        let button = HighLightButton(image: UIImage.newMessageIcon(size: CGSize(width: kNewMessageIconSize, height: kNewMessageIconSize), color: UIColor.whiteColor()), highlightedImage: UIImage.newMessageIcon(size: CGSize(width: kNewMessageIconSize, height: kNewMessageIconSize), color: UIColor.whiteColor().colorWithAlphaComponent(0.5)), alignment: UIControlContentHorizontalAlignment.Right)
        button.addTarget(self, action: #selector(ConversationsViewController.newMessageButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Show header for offer wall
        if NativeXSDK.isAdFetchedWithName(String.NativeXOfferWallPlacementName()) {
            if self.tableNode.view.tableHeaderView == nil {
                let headerView = OfferWallHeader(frame: CGRect(origin: CGPointZero, size: CGSize(width: self.tableNode.frame.size.width, height: 54)))
                self.tableNode.view.tableHeaderView = headerView
            }
            else {
                RewardManager.getRewards()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func newMessageButtonTapped() {
        let searchViewController = SearchViewController()
        searchViewController.delegate = self
        searchViewController.type = .Message
        let navigationController = UINavigationController(rootViewController: searchViewController)
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    //MARK: SearchViewControllerDelegate
    func searchViewControllerDidSelectUser(searchViewController: SearchViewController, user: User) {
        let chatViewController = ChatViewController()
        chatViewController.user = user
        navigationController?.pushViewController(chatViewController, animated: false)
        searchViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TabbarItemDelegate
    func viewControllerScrollViewGoesToTop() {
        tableNode.view.setContentOffset(CGPointZero, animated: true)
    }
    
    //MARK: ConversationListUpdater
    func addNewMessageToConversation(message: String, user: User?, conversationId: String?, timeStamp: NSDate) {
        _dataSource.addNewMessageToConversation(message, user: user, conversationId: conversationId, timeStamp: timeStamp)
    }
    
    func updateNewMessageFromUser(user: User, message: Message) {
        _dataSource.updateNewMessageFromUser(user, message: message)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol ConversationListUpdater : NSObjectProtocol{
    func addNewMessageToConversation(message: String, user: User?, conversationId: Int64?, timeStamp: NSDate)
    func updateNewMessageFromUser(user: User, message: Message)
}
