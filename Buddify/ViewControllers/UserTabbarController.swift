//
//  UserTabbarController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 13/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

private let kBarHeight: CGFloat = 49

import AsyncDisplayKit
import Models
import BDFClientApi

public class UserTabbarController: UITabBarController, UITabBarControllerDelegate {
    private var _bar: UIView!
    private var _oldSelectedIndex = 0
    private var _isFirstLoad = true
    
    let discoveryViewController = DiscoveryViewController()
    let conversationsViewController = ConversationsViewController()
    let feedViewController = FeedViewController()
    let notificationsViewController = NotificationCenterViewController()
    let profileViewController = ProfileViewController()
    
    override public func loadView() {
        super.loadView()
        self.setUpTabbarItems()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.commonInit()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: WebServicesRefreshTokenExpiredNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: WebServicesTokensUpdatedNotificationKey, object: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Prompt push notification
        if _isFirstLoad {
            _isFirstLoad = false
            BDFPushNotificationHelper.askForPushNotificationToken()
        }
    }
    
    override public func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    internal func commonInit() {
        self.delegate = self
		
        //profileViewController.user = Me.sharedInstance!
        
        let navigationController1 = UINavigationController(rootViewController: discoveryViewController)
        let navigationController2 = UINavigationController(rootViewController: conversationsViewController)
        let navigationController3 = UINavigationController(rootViewController: feedViewController)
        let navigationController4 = UINavigationController(rootViewController: notificationsViewController)
        
        profileViewController.user = BDFAuthenticatedUser.currentUser
        let navigationController5 = UINavigationController(rootViewController: profileViewController)
        
        self.viewControllers = [navigationController1, navigationController2, navigationController3, navigationController4, navigationController5]
        
        self.setUpTabbarItems()
        
        // Listen tokens refresh token outdated in here
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleExpiredRefreshTokenNotification(_:)), name: WebServicesRefreshTokenExpiredNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleTokensUpdatedNotification(_:)), name: WebServicesTokensUpdatedNotificationKey, object: nil)
        
    }
    
    private func setUpTabbarItems() {
        guard let items = self.tabBar.items else {
            return
        }
		
		//Add bar into tab bar
		_bar = UIView(frame: CGRect(x: 0, y: self.tabBar.frame.size.height - kBarHeight, width: self.tabBar.frame.width/CGFloat(items.count), height: kBarHeight))
		_bar.backgroundColor = UIColor.appPurpleColor()
		_bar.autoresizingMask = [UIViewAutoresizing.FlexibleWidth]
		self.tabBar.addSubview(_bar)
        
        let tabbarItemInset : CGFloat = -6
        let selectedColor = UIColor.whiteColor()
        let normalColor = UIColor.appLightTextColor()
        
        let discoveryIcon = UIImage.tabbarDiscoveryIcon(size: CGSize(width: 25, height: 25), color: normalColor)
        let discoveryIconSelected = UIImage.tabbarDiscoveryIcon(size: CGSize(width: 25, height: 25), color: selectedColor)
        
        let conversationIcon = UIImage.tabbarConversationIcon(size: CGSize(width: 25, height: 25), color: normalColor)
        let conversationIconSelected = UIImage.tabbarConversationIcon(size: CGSize(width: 25, height: 25), color: selectedColor)
        
        let profileIcon = UIImage.tabbarProfileIcon(size: CGSize(width: 25, height: 25), color: normalColor)
        let profileIconSelected = UIImage.tabbarProfileIcon(size: CGSize(width: 25, height: 25), color: selectedColor)
        
        let timelineIcon = UIImage.tabbarTimelineIcon(size: CGSize(width: 25, height: 25), color: normalColor)
        let timelineIconSelected = UIImage.tabbarTimelineIcon(size: CGSize(width: 25, height: 25), color: selectedColor)
        
        let notificationIcon = UIImage.tabbarNotificationIcon(size: CGSize(width: 25, height: 25), color: normalColor)
        let notificationIconSelected = UIImage.tabbarNotificationIcon(size: CGSize(width: 25, height: 25), color: selectedColor)
        
        for (index, item) in items.enumerate() {
            item.titlePositionAdjustment = UIOffsetMake(0, 49)
            item.imageInsets = UIEdgeInsets(top: -tabbarItemInset, left: 0, bottom: tabbarItemInset, right: 0)
            if index == 0 {
                item.image = discoveryIcon.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage = discoveryIconSelected.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else if index == 1 {
                item.image = conversationIcon.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage = conversationIconSelected.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else if index == 2 {
                item.image = timelineIcon.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage = timelineIconSelected.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else if index == 3 {
                item.image = notificationIcon.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage = notificationIconSelected.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
            else if index == 4 {
                item.image = profileIcon.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                item.selectedImage = profileIconSelected.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            }
        }
    }

    
    //MARK: UITabbarViewControllerDelegate
    public override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if let index = self.tabBar.items?.indexOf(item) {
            _bar.frame.origin.x = CGFloat(index) * _bar.frame.size.width
        }
    }
    
    public func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if _oldSelectedIndex == tabBarController.selectedIndex {
            if let navigationController = viewController as? UINavigationController {
                if navigationController.viewControllers.count == 1 {
                    if let currentViewController = navigationController.viewControllers[0] as? TabbarItemDelegate {
                        currentViewController.viewControllerScrollViewGoesToTop()
                    }
                }
            }
        }
        
        _oldSelectedIndex = tabBarController.selectedIndex
    }
}

// Handle token notifications generated by the web services
extension UserTabbarController {
    func handleExpiredRefreshTokenNotification(notification: NSNotification) {
        // Log out
        BDFAuthenticatedUser.currentUser.destroy()
        AppDelegate.logOut()
    }
    
    func handleTokensUpdatedNotification(notification: NSNotification) {
        // Save user data when token is updated.
        BDFAuthenticatedUser.currentUser.save()
    }
}
