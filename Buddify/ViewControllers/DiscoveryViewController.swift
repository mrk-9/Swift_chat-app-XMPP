//
//  DiscoveryViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 08/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Models

private var rowSpacingTop: CGFloat = 5
private var rowSpacing: CGFloat = 8
private var columnSpacing: CGFloat = 8
private var numberOfColumns: UInt = 2

private var searchTextFieldNodeX: CGFloat = 0
private var searchTextFieldNodeY: CGFloat = 0
private var searchTextFieldNodeWidth: CGFloat = CGSize.screenSize.width
private var searchTextFieldNodeHeight: CGFloat = 108/2

private let kFilterIconSize: CGFloat = 25

private let kSearchIconSize: CGFloat = 20

private let searchTextFieldVerticalIndent : CGFloat = 19
private let searchTextFieldHorizontalIndent : CGFloat = 19
private let kFilterStatsHeight: CGFloat = 34

class DiscoveryViewController: ASViewController, ASEditableTextNodeDelegate, UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate, TabbarItemDelegate {
    private var collectionNode: ASCollectionNode!
    private var _dataSource: DiscoveryDataSource!
    private let _interactiveTransition = WYInteractiveTransitions()
    private var _filterStatsNode: FilterStatsNode!
    private var _firstLoad = true
    
    // This is flag to check if discovery view should refresh the whole page when viewWillAppear
    // For example, when discovery location changes.
    private var _shouldRefresh = true
    
    // Getting user location callback might be call multiple times, check UserLocationUtilityDelegate
    // We need to have a property to check if user location has been updated.
    private var _didGetLocation = false

    init() {
        // Do any additional setup after loading the view.
		
		//layout collection view
        let flowLayout = MosaicCollectionViewLayout()
        flowLayout.numberOfColumns = numberOfColumns
        flowLayout.headerHeight = 0
        flowLayout.sectionInset = UIEdgeInsets(top: kFilterStatsHeight, left: columnSpacing, bottom: rowSpacingTop, right: columnSpacing)
        flowLayout.interItemSpacing = UIEdgeInsets(top: rowSpacing, left: rowSpacing, bottom: rowSpacing, right: rowSpacing)
        flowLayout.columnSpacing = columnSpacing
		
		//asviewcontroller init with collection node
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        
        super.init(node: collectionNode)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = true
        self.title = "Discovery"
        self.view.autoresizesSubviews = true
		
        collectionNode.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        collectionNode.view.alwaysBounceVertical = true
        collectionNode.view.leadingScreensForBatching = 2
        
        _dataSource = DiscoveryDataSource(collectionNode: collectionNode, viewController: self)
		
		//add searchTextFieldNode
        _filterStatsNode = FilterStatsNode(minAge: FilterStats.sharedStats.minAge, maxAge: FilterStats.sharedStats.maxAge, gender: FilterStats.sharedStats.gender, radius: FilterStats.sharedStats.radius)
        _filterStatsNode.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.node.bounds.size.width, height: kFilterStatsHeight))
        _filterStatsNode.measureWithSizeRange(ASSizeRange(min: CGSize(width: self.node.bounds.size.width, height: kFilterStatsHeight), max: CGSize(width: self.node.bounds.size.width, height: kFilterStatsHeight)))
		self.view.addSubnode(_filterStatsNode)
        
        //Filter button
		let filterButton = HighLightButton(image: UIImage.filterIcon(size: CGSize(width: kFilterIconSize, height: kFilterIconSize), color: UIColor.whiteColor()), highlightedImage: UIImage.filterIcon(size: CGSize(width: kFilterIconSize, height: kFilterIconSize), color: UIColor(white: 1.0, alpha: 0.4)), alignment: UIControlContentHorizontalAlignment.Left)
        filterButton.addTarget(self, action: #selector(DiscoveryViewController.filterButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
		
        //Search button
		let searchButton = HighLightButton(image: UIImage.searchIcon(size: CGSize(width: kSearchIconSize, height: kSearchIconSize), color: UIColor.whiteColor()), highlightedImage: UIImage.searchIcon(size: CGSize(width: kSearchIconSize, height: kSearchIconSize), color: UIColor(white: 1.0, alpha: 0.4)), alignment: UIControlContentHorizontalAlignment.Right)
        searchButton.addTarget(self, action: #selector(DiscoveryViewController.searchButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
	
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if _firstLoad {
            _firstLoad = false
            
            // The first time open discovery view, update user location
            UserLocationUtility.sharedInstance.getUserLocation()
            
            // If user discovery mode is using custom location, start loading users immmediately
            if let location = DiscoverySearchLocationProvider.defaultProvider.selectedLocation {
                _dataSource.discoveryCoordinates = location.coordinate
            }
        }
        
        // Check everytime if we should refresh the page
        if _shouldRefresh {
            _shouldRefresh = false
            _dataSource.refresh(nil)
        }
        
        UserLocationUtility.sharedInstance.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Present offer wall
        //Woobi.showOffers(self, String.WoobiAppID(), String("56"), nil, "success", "1")
        //Woobi.getSponsoredBy(self, String.WoobiAppID(), String("56"), nil, nil, "1", sponsoredByListener: nil, true)
        //Woobi.showNonIncentivizedPopup(self, String.WoobiAppID(), String("56"), nil, nil, "1", WoobiAdType.WOOBI_APP_INSTALL, WoobiAnimationType.WOOBI_NONE)
        NativeXSDK.fetchAdsAutomaticallyWithName(String.NativeXOfferWallPlacementName(), enabled: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        collectionNode.view.stopLoading()
    }
    
    deinit {
        collectionNode.view.removeLoadingManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	//Dismiss keyboard
    internal func filterButtonTapped() {
        let filterViewController = FilterViewController()
        filterViewController.delegate = self

		//filterViewController.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
		let navigationController = UINavigationController(rootViewController: filterViewController)
        
        //Custom
        _interactiveTransition.configureTransition(toView: navigationController, panEnable: false, type: WYTransitoinType.Up)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    internal func searchButtonTapped() {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    //MARK: TabbarItemDelegate
    func viewControllerScrollViewGoesToTop() {
        collectionNode.view.setContentOffset(CGPointZero, animated: true)
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

//MARK: FilterViewControllerDelegate
extension DiscoveryViewController: FilterViewControllerDelegate {
    func filterViewControllerDidChangeDiscoveryLocation(filterViewController: FilterViewController, location: DiscoverySearchLocation?) {
        // Update discovery location
        _dataSource.discoveryCoordinates = location?.coordinate
        
        // Update flag so the view will be updated when it appears again.
        _shouldRefresh = true
    }
    
    func filterViewControllerDidSelectGender(filterViewController: FilterViewController, gender: BDFUserGender, ageRange: (Int, Int), distanceInKm: Int) {
        //Save filters into user defaults
        FilterStats.setMinAge(ageRange.0, maxAge: ageRange.1, genderSelection: gender, radius: distanceInKm)
        _filterStatsNode.setInfo(ageRange.0, maxAge: ageRange.1, gender: gender, radius: distanceInKm)
        
        // Update flag so the view will be updated when it appears again.
        _shouldRefresh = true
    }
}

//MARK: UserLocationUtilityDelegate
extension DiscoveryViewController: UserLocationUtilityDelegate {
    func userLocationUtilityDidGetLocation(location: CLLocation) {
        // Update user location in backend, make sure it will be called only once.
        if !_didGetLocation {
            _didGetLocation = true
            
            BDFAuthenticatedUser.currentUser.updateUserLocation(location.coordinate.longitude, latitude: location.coordinate.latitude, successBlock: {
                // Call discovery only if using default current location
                if DiscoverySearchLocationProvider.defaultProvider.selectedLocation == nil {
                    // Update current location
                    self._dataSource.discoveryCoordinates = location.coordinate
                    self._dataSource.refresh(nil)
                }
                
            }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                // Display error message
            }
        }
    }
    
    func userLocationUtilityPresentViewController(alertController: UIAlertController) {
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

class FilterStatsNode: ASDisplayNode {
    private let descriptionNode = ASTextNode()
    
    init(minAge: Int, maxAge: Int, gender: BDFUserGender, radius: Int) {
        super.init()
        self.addSubnode(descriptionNode)
        self.setInfo(minAge, maxAge: maxAge, gender: gender, radius: radius)
    }
    
    func setInfo(minAge: Int, maxAge: Int, gender: BDFUserGender, radius: Int) {
        self.clearContents()
        
        var genderText: String
        if gender == .Male {
            genderText = "Men"
        }
        else if gender == .Female {
            genderText = "Women"
        }
        else {
            genderText = "Men & Women"
        }
        
        let string = "\(minAge)-\(maxAge)  •  \(genderText)  •  \(radius)km"
        descriptionNode.attributedString = NSAttributedString.attributedStringFromFont(string, font: UIFont.appFont(CGFloat.smallFontSize), textColor: UIColor.appPurpleColor(), textAlignment: NSTextAlignment.Center)
        
        descriptionNode.invalidateCalculatedLayout()
        
        self.setNeedsLayout()
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        descriptionNode.flexGrow = true
        
        let stackSpec = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 20, justifyContent: ASStackLayoutJustifyContent.SpaceAround, alignItems: ASStackLayoutAlignItems.Center, children: [descriptionNode])
        
        return stackSpec
    }
}
