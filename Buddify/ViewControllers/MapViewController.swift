//
//  MapViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 24/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

import UIKit
import DTParallaxScrollViewController
import AsyncDisplayKit
import MapKit

private let cellIdentifier = "Cell"
private let kHeaderHeight: CGFloat = 300
private let kDefaultEyeAltitude: Double = 40000

///
/// Protocol BDFLocationPickerControllerDelegate
///
public protocol BDFLocationPickerControllerDelegate: NSObjectProtocol {
    func locationPickerControllerDidPickLocation(locationPickerController: BDFLocationPickerController, location: DiscoverySearchLocation?)
}

///
/// Class MapViewController
///
public class BDFLocationPickerController: DTParallaxScrollViewController {
    struct CurrentLocationListener {
        let once: Bool
        let action: (CLLocation) -> ()
    }
    
    public var completion: (DiscoverySearchLocation? -> ())?
    
    /// Delegate
    public var locationDelegate: BDFLocationPickerControllerDelegate?
    
    // region distance to be used for creation region when user selects place from search results
    public var resultRegionDistance: CLLocationDistance = 600
    
    /// default: true
    public var showCurrentLocationButton = false
    
    /// default: true
    public var showCurrentLocationInitially = true
    
    /// see `region` property of `MKLocalSearchRequest`
    /// default: false
    public var useCurrentLocationAsHint = false
    
    /// default: "Search or enter an address"
    public var searchBarPlaceholder = "Search or enter an address"
    
    /// default: "Search History"
    public var searchHistoryLabel = "Search History"
    
    /// default: "Select"
    public var selectButtonTitle = "Select"
    
    lazy public var currentLocationButtonBackground: UIColor = {
        if let navigationBar = self.navigationController?.navigationBar,
            barTintColor = navigationBar.barTintColor {
            return barTintColor
        } else { return .whiteColor() }
    }()
    
    /// default: .Minimal
    public var searchBarStyle: UISearchBarStyle = .Minimal
    
    /// default: .Default
    public var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.LightContent
    
    public var mapType: MKMapType = .Hybrid {
        didSet {
            if isViewLoaded() {
                _mapView.mapType = mapType
            }
        }
    }
    
    public var location: DiscoverySearchLocation? {
        didSet {
            if isViewLoaded() {
                searchBar.text = location.flatMap({ $0.title }) ?? ""
                updateAnnotation()
            }
        }
    }
    
    static let SearchTermKey = "SearchTermKey"
    
    let historyManager = SearchHistoryManager()
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var localSearch: MKLocalSearch?
    var searchTimer: NSTimer?
    
    var currentLocationListeners: [CurrentLocationListener] = []
    
    lazy var results: LocationSearchResultsViewController = {
        let results = LocationSearchResultsViewController()
        results.onSelectLocation = { [weak self] in self?.selectedLocation($0) }
        results.searchHistoryLabel = self.searchHistoryLabel
        return results
    }()
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: self.results)
        search.searchResultsUpdater = self
        search.hidesNavigationBarDuringPresentation = false
        return search
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = self.searchController.searchBar
        searchBar.searchBarStyle = self.searchBarStyle
        searchBar.placeholder = self.searchBarPlaceholder
        return searchBar
    }()
    
    deinit {
        searchTimer?.invalidate()
        localSearch?.cancel()
        geocoder.cancelGeocode()
        // http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller/
        let _ = searchController.view
    }
    
    public override func loadView() {
        super.loadView()
        if showCurrentLocationButton {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
            button.backgroundColor = currentLocationButtonBackground
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 16
            let bundle = NSBundle(forClass: self.dynamicType)
            button.setImage(UIImage(named: "geolocation", inBundle: bundle, compatibleWithTraitCollection: nil), forState: .Normal)
            button.addTarget(self, action: #selector(self.dynamicType.currentLocationPressed),
                             forControlEvents: .TouchUpInside)
            view.addSubview(button)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        _tableNode.delegate = self
        _tableNode.dataSource = self
        _tableNode.view.allowsMultipleSelection = false
        _tableNode.view.separatorStyle = .None
        _tableNode.view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.parallaxScrollView.alwaysBounceVertical = true
        
        //_tableNode.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.delegate = self
        
        self.title = "Current location"
        
        /// Get locations
        _locations = DiscoverySearchLocationProvider.defaultProvider.currentLocations
        
        // Location button 40 x 40
        _locationButton.frame = CGRect(x: self.view.frame.width - 50, y: kHeaderHeight - 50, width: 40, height: 40)
        _locationButton.addTarget(self, action: #selector(self.dynamicType.locationButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        let image = UIImage.currentLocationIcon(size: CGSize(width: 20, height: 20), color: UIColor.whiteColor())
        DTLog(image.size)
        _locationButton.setImage(image, forState: UIControlState.Normal)
        _locationButton.backgroundColor = UIColor.appPurpleColor()
        _locationButton.layer.cornerRadius = 20
        _locationButton.layer.masksToBounds = true
        
        self.parallaxScrollView.addSubview(_locationButton)
        
        locationManager.delegate = self
        _mapView.delegate = self
        searchBar.delegate = self
        // Change search bar text color
        if let searchTextField = self.searchBar.valueForKey("searchField") as? UITextField {
            searchTextField.textColor = UIColor.whiteColor()
            searchTextField.attributedPlaceholder = NSAttributedString.attributedStringFromFont(searchBarPlaceholder, font: UIFont.appFont(15), textColor: UIColor(white: 1.0, alpha: 0.5), textAlignment: nil)
        }
        
        _mapView.frame = CGRect(x: 0, y: -100, width: self.view.frame.width, height: kHeaderHeight + 200)
        _mapView.tintColor = UIColor.appPinkColor()
        
        self.updateBlock = {(yOffset: CGFloat, visible: Bool) -> Void in
            if yOffset < 0 {
                let scaleFactor = 1 + abs(yOffset/self.headerHeight)
                self._mapView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
            }
            else {
                self._mapView.transform = CGAffineTransformIdentity
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        // gesture recognizer for adding by tap
        _mapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self,
            action: #selector(self.dynamicType.addLocation(_:))))
        
        // search
        navigationItem.titleView = searchBar
        definesPresentationContext = true
        
        // user location
        _mapView.userTrackingMode = .None
        _mapView.showsUserLocation = showCurrentLocationInitially || showCurrentLocationButton
        
        if useCurrentLocationAsHint {
            getCurrentLocation()
        }
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return statusBarStyle
    }
    
    var presentedInitialLocation = false
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // setting initial location here since viewWillAppear is too early, and viewDidAppear is too late
        if !presentedInitialLocation {
            setInitialLocation()
            presentedInitialLocation = true
        }
    }
    
    public override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setInitialLocation() {
        if let location = location {
            // present initial location if any
            self.location = location
            showCoordinates(location.coordinate, animated: false)
        } else if showCurrentLocationInitially {
            showCurrentLocation(false)
        }
    }
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func currentLocationPressed() {
        showCurrentLocation()
    }
    
    func showCurrentLocation(animated: Bool = true) {
        let listener = CurrentLocationListener(once: true) { [weak self] location in
            self?.showCoordinates(location.coordinate, animated: animated)
        }
        currentLocationListeners.append(listener)
        getCurrentLocation()
    }
    
    func updateAnnotation() {
        _mapView.removeAnnotations(_mapView.annotations)
        if let location = location {
            _mapView.addAnnotation(location)
            _mapView.selectAnnotation(location, animated: true)
        }
    }
    
    func showCoordinates(coordinate: CLLocationCoordinate2D, animated: Bool = true) {
        let region = MKCoordinateRegionMakeWithDistance(coordinate, resultRegionDistance, resultRegionDistance)
        _mapView.setRegion(region, animated: animated)
    }
    
    
    ///
    ///  Array of locations
    ///
    private var _locations: [DiscoverySearchLocation]!
    
    // Pin annotation on the map
    private var _annotation: MapPin?
    
    private let _tableNode: ASTableNode = ASTableNode()
    
    // Map view controller
    private let _mapView = MKMapView()
    
    // User's current location button
    private let _locationButton = HighLightButton()
    
    init() {
        super.init(scrollView: _tableNode.view, headerHeight: kHeaderHeight)
    }
    
    override public func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get user's current location
        UserLocationUtility.sharedInstance.delegate = self
        UserLocationUtility.sharedInstance.getUserLocation()
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Save the list and current selected location
        var index = -1
        if let indexPath = _tableNode.view.indexPathForSelectedRow {
            index = indexPath.row - 1
        }
        
        DiscoverySearchLocationProvider.defaultProvider.saveLocations(_locations, selectedIndex: index)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationButtonTapped(button: UIButton?) {
        // Tell map to go to the location
        let camera = MKMapCamera(lookingAtCenterCoordinate: _mapView.userLocation.coordinate, fromEyeCoordinate: _mapView.userLocation.coordinate, eyeAltitude: kDefaultEyeAltitude)
        _mapView.setCamera(camera, animated: true)
    }
}

//MARK: MapViewController
extension BDFLocationPickerController: DTParallaxScrollViewDelegate {
    public func parallaxScrollViewViewForHeader(viewController: DTParallaxScrollView) -> UIView {
        return _mapView
    }
}

extension BDFLocationPickerController {
    override public func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    //    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
    //        return UIStatusBarStyle.LightContent
    //    }
}

extension BDFLocationPickerController: ASTableViewDataSource, ASTableViewDelegate {
    // Number of rows is always equal or greater than 1
    // The first row is current user location and following are the custom location added by user.
    // Those custom locations are _locations array which will be first read from disk using DiscoverySearchLocationProvider.
    // So be careful working with NSIndexPath in this view.
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _locations.count + 1
    }
    
    public func tableView(tableView: ASTableView, nodeForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
        if indexPath.row == 0 {
            let node = LocationNode(locationName: "Current location")
            node.delegate = self
            
            return node
        }
        
        let location = self._locations[indexPath.row - 1]
        let node = LocationNode(locationName: location.address ?? "Current location")
        node.delegate = self
        
        return node
    }
    
    public func tableView(tableView: ASTableView, willDisplayNodeForRowAtIndexPath indexPath: NSIndexPath) {
        // Set select row
        if indexPath.row == 0 {
            if DiscoverySearchLocationProvider.defaultProvider.selectedLocation == nil {
                _tableNode.view.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            }
        }
        else {
            if DiscoverySearchLocationProvider.defaultProvider.selectedLocation == _locations[indexPath.row - 1] {
                _tableNode.view.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            }
        }
    }
}

//MARK:  LocationNodeDelegate
extension BDFLocationPickerController: LocationNodeDelegate {
    func locationNodeButtonTapped(node: LocationNode) {
        if let indexPath = self._tableNode.view.indexPathForNode(node) {
            // Select row
            _tableNode.view.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
            
            if _annotation != nil {
                _mapView.removeAnnotation(_annotation!)
            }
            
            // Selected location
            var location: DiscoverySearchLocation?
            
            if indexPath.row == 0 {
                // Tell map to go to the location
                let camera = MKMapCamera(lookingAtCenterCoordinate: _mapView.userLocation.coordinate, fromEyeCoordinate: _mapView.userLocation.coordinate, eyeAltitude: kDefaultEyeAltitude)
                _mapView.setCamera(camera, animated: true)
            }
            else {
                location = _locations[indexPath.row - 1]
                
                // Update info for annotation
                let annotation = MapPin(coordinate: location!.coordinate, title: location!.address, subtitle: nil)
                _annotation = annotation
                _mapView.addAnnotation(annotation)
                
                _mapView.setCamera(MKMapCamera(lookingAtCenterCoordinate: _mapView.centerCoordinate, fromEyeCoordinate: location!.coordinate, eyeAltitude: 100000), animated: false)
                
                // Tell map to go to the location
                let camera = MKMapCamera(lookingAtCenterCoordinate: location!.coordinate, fromEyeCoordinate: location!.coordinate, eyeAltitude: kDefaultEyeAltitude)
                _mapView.setCamera(camera, animated: true)
            }
            
            // Call delegate method
            locationDelegate?.locationPickerControllerDidPickLocation(self, location: location)
            
        }
    }
}

//MARK: MKMapViewDelegate
//extension MapViewController: MKMapViewDelegate {
//    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation.isKindOfClass(MKUserLocation) {
//            return nil
//        }
//
//        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//        view.pinColor = MKPinAnnotationColor.Purple
//        view.canShowCallout = true
//        return view
//    }
//}

//MARK: UserLocationUtility
extension BDFLocationPickerController: UserLocationUtilityDelegate {
    func userLocationUtilityDidGetLocation(location: CLLocation) {
        
    }
    
    func userLocationUtilityPresentViewController(alertController: UIAlertController) {
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

///
/// Class MapPin
///
class MapPin : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

extension BDFLocationPickerController: CLLocationManagerDelegate {
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        for listener in currentLocationListeners {
            listener.action(location)
        }
        currentLocationListeners = currentLocationListeners.filter { !$0.once }
        manager.stopUpdatingLocation()
    }
}

// MARK: Searching

extension BDFLocationPickerController: UISearchResultsUpdating {
    public func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let term = searchController.searchBar.text else { return }
        
        searchTimer?.invalidate()
        
        let whitespaces = NSCharacterSet.whitespaceCharacterSet()
        let searchTerm = term.stringByTrimmingCharactersInSet(whitespaces)
        
        if searchTerm.isEmpty {
            results.locations = historyManager.history()
            results.isShowingHistory = true
            results.tableView.reloadData()
        } else {
            // clear old results
            showItemsForSearchResult(nil)
            
            searchTimer = NSTimer.scheduledTimerWithTimeInterval(0.2,
                                                                 target: self, selector: #selector(self.dynamicType.searchFromTimer(_:)),
                                                                 userInfo: [self.dynamicType.SearchTermKey: searchTerm],
                                                                 repeats: false)
        }
    }
    
    func searchFromTimer(timer: NSTimer) {
        guard let userInfo = timer.userInfo as? [String: AnyObject],
            term = userInfo[self.dynamicType.SearchTermKey] as? String
            else { return }
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = term
        
        if let location = locationManager.location where useCurrentLocationAsHint {
            request.region = MKCoordinateRegion(center: location.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        }
        
        localSearch?.cancel()
        localSearch = MKLocalSearch(request: request)
        localSearch!.startWithCompletionHandler { response, error in
            self.showItemsForSearchResult(response)
        }
    }
    
    func showItemsForSearchResult(searchResult: MKLocalSearchResponse?) {
        results.locations = searchResult?.mapItems.map { DiscoverySearchLocation(name: $0.name, placemark: $0.placemark) } ?? []
        results.isShowingHistory = false
        results.tableView.reloadData()
    }
    
    func selectedLocation(location: DiscoverySearchLocation) {
        // dismiss search results
        dismissViewControllerAnimated(true) {
            // set location, this also adds annotation
            self.location = location
            self.showCoordinates(location.coordinate)
            
            self.historyManager.addToHistory(location)
        }
    }
}

// MARK: Selecting location with gesture

extension BDFLocationPickerController {
    func addLocation(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .Began {
            let point = gestureRecognizer.locationInView(_mapView)
            let coordinates = _mapView.convertPoint(point, toCoordinateFromView: _mapView)
            let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
            
            // clean location, cleans out old annotation too
            self.location = nil
            
            // add point annotation to map
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            _mapView.addAnnotation(annotation)
            
            geocoder.cancelGeocode()
            
            // Getting location name
            geocoder.reverseGeocodeLocation(location) { response, error in
                if let error = error {
                    // show error and remove annotation
                    let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { _ in }))
                    self.presentViewController(alert, animated: true) {
                        self._mapView.removeAnnotation(annotation)
                    }
                } else if let placemark = response?.first {
                    // get POI name from placemark if any
                    let name = placemark.areasOfInterest?.first
                    
                    // pass user selected location too
                    self.location = DiscoverySearchLocation(name: name, location: location, placemark: placemark)
                }
            }
        }
    }
}

// MARK: MKMapViewDelegate

extension BDFLocationPickerController: MKMapViewDelegate {
    public func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        pin.pinColor = .Green
        // drop only on long press gesture
        let fromLongPress = annotation is MKPointAnnotation
        pin.animatesDrop = fromLongPress
        pin.rightCalloutAccessoryView = selectLocationButton()
        pin.canShowCallout = !fromLongPress
        return pin
    }
    
    func selectLocationButton() -> UIButton {
        let button = HighLightButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        button.setTitle(selectButtonTitle, forState: .Normal)
        if let titleLabel = button.titleLabel {
            let width = titleLabel.textRectForBounds(CGRect(x: 0, y: 0, width: Int.max, height: 30), limitedToNumberOfLines: 1).width
            button.frame.size = CGSize(width: width, height: 30.0)
        }
        button.setTitleColor(_mapView.tintColor, forState: .Normal)
        return button
    }
    
    public func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        completion?(location)
        // Save new location
        if let _location = location {
            // Call delegate method
            locationDelegate?.locationPickerControllerDidPickLocation(self, location: location)
            
            // If location is already in the list
            if let index = _locations.indexOf(_location) {
                let indexPath = NSIndexPath(forRow: index + 1, inSection: 0)
                self._tableNode.view.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
                return
            }
            
            _locations.insert(_location, atIndex: 0)
            
            // Update table view
            let indexPath = NSIndexPath(forRow: 1, inSection: 0)
            
            self._tableNode.view.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            // Use delay to select row right after selection, works best with 0.1 seconds
            delay(0.1, block: {
                self._tableNode.view.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            })
        }
    }
    
    public func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        let pins = mapView.annotations.filter { $0 is MKPinAnnotationView }
        assert(pins.count <= 1, "Only 1 pin annotation should be on map at a time")
    }
}

// MARK: UISearchBarDelegate

extension BDFLocationPickerController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        // dirty hack to show history when there is no text in search bar
        // to be replaced later (hopefully)
        if let text = searchBar.text where text.isEmpty {
            searchBar.text = " "
        }
    }
    
    public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // remove location if user presses clear or removes text
        if searchText.isEmpty {
            location = nil
            searchBar.text = " "
        }
    }
}
