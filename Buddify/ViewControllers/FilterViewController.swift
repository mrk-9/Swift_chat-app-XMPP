//
//  FilterViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 18/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import Models

private let kDoneButtonHeight: CGFloat = 80

private let kFilterAgeRangeCellIdentifier = "FilterAgeRangeCellIdentifier"
private let kFilterDistanceCellIdentifier = "FilterDistanceCellIdentifier"
private let kFilterGenderCellIdentifier = "FilterGenderCellIdentifier"
private let kFilterLocationCellIdentifier = "FilterLocationCellIdentifier"

protocol FilterViewControllerDelegate: NSObjectProtocol {
    func filterViewControllerDidSelectGender(filterViewController: FilterViewController, gender: BDFUserGender, ageRange: (Int, Int), distanceInKm: Int)
    func filterViewControllerDidChangeDiscoveryLocation(filterViewController: FilterViewController, location: DiscoverySearchLocation?)
}

public class FilterViewController: UITableViewController {
    weak var delegate: FilterViewControllerDelegate?
    
    private let _doneButton: UIButton!
    private var _birthdate: NSDate?
    private var _gender: Bool?
    private var _profileImage: UIImage?
    private var _genderCell: FilterGenderCell!
    private var _distanceCell: FilterDistanceCell!
    private var _ageRangeCell: FilterAgeCell!
    
    init() {
        _doneButton = UIButton(type: UIButtonType.Custom)
        _doneButton.backgroundColor = UIColor.appPinkColor()
        _doneButton.titleLabel?.font = UIFont.boldAppFont(CGFloat.bigFontSize)
        _doneButton.setTitle("Done", forState: UIControlState.Normal)
        super.init(style: UITableViewStyle.Plain)
        //self.extendedLayoutIncludesOpaqueBars = true
        //self.edgesForExtendedLayout = [UIRectEdge.Bottom, UIRectEdge.Top]
		//self.automaticallyAdjustsScrollViewInsets = true

    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //Getter
    public func ageRange() -> (Int, Int) {
        return (0, 100)
    }
    
    internal func radius() -> Int {
        return 100
    }
    
    internal func sex() -> Int {
        return 0
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Filters"
		
		//table view
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.scrollEnabled = false
		self.tableView.registerClass(FilterAgeCell.self, forCellReuseIdentifier: kFilterAgeRangeCellIdentifier)
		self.tableView.registerClass(FilterDistanceCell.self, forCellReuseIdentifier: kFilterDistanceCellIdentifier)
		self.tableView.registerClass(FilterGenderCell.self, forCellReuseIdentifier: kFilterGenderCellIdentifier)
        self.tableView.registerNib(UINib.init(nibName: "FilterLocationCell", bundle: nil), forCellReuseIdentifier: kFilterLocationCellIdentifier)
		
		//done button
        _doneButton.frame = CGRect(x: 0, y: self.view.bounds.height - kDoneButtonHeight - 44, width: self.view.bounds.width, height: kDoneButtonHeight)
        _doneButton.addTarget(self, action: #selector(FilterViewController.doneButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		self.view.addSubview(_doneButton)
		
        let cancelButton = HighLightButton(image: UIImage.cancelIcon(size: CGSize(width: 15, height: 15), color: UIColor.whiteColor()), alignment: UIControlContentHorizontalAlignment.Left)
        cancelButton.addTarget(self, action: #selector(self.dynamicType.dismissViewController), forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
	
	override public func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
	}
	
    //MARK: Methods
    internal func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    internal func doneButtonTapped() {
        delegate?.filterViewControllerDidSelectGender(self, gender: _genderCell.selectedGender, ageRange: (_ageRangeCell.minAge, _ageRangeCell.maxAge), distanceInKm: _distanceCell.distance)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    internal func ageRangeDidChanged() {
        _ageRangeCell.descriptionLabel.text = "\(Int(_ageRangeCell.slider.fromValue)) - \(Int(_ageRangeCell.slider.toValue))"
    }
    
    internal func radiusDidChanged() {
        _distanceCell.descriptionLabel.text = "\(Int(_distanceCell.slider.value))km"
    }
	
    //MARK: ASTableViewDataSource
    public override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
	
    public override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 0 {
            
        }
        else if indexPath.row == 2 {
            
        }
    }
	
    public override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = tableView.dequeueReusableCellWithIdentifier(kFilterGenderCellIdentifier, forIndexPath: indexPath) as! FilterGenderCell
			//cell.multipleSelection = true
			_genderCell = cell
			_genderCell.selectedGender = FilterStats.sharedStats.gender
			return cell
		}
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(kFilterAgeRangeCellIdentifier, forIndexPath: indexPath) as! FilterAgeCell
            cell.slider.addTarget(self, action: #selector(FilterViewController.ageRangeDidChanged), forControlEvents: UIControlEvents.ValueChanged)
            _ageRangeCell = cell
            _ageRangeCell.minAge = FilterStats.sharedStats.minAge
            _ageRangeCell.maxAge = FilterStats.sharedStats.maxAge
            _ageRangeCell.descriptionLabel.text = "\(FilterStats.sharedStats.minAge) - \(FilterStats.sharedStats.maxAge)"
            return cell
        }
		else  if indexPath.row == 2 {
			let cell = tableView.dequeueReusableCellWithIdentifier(kFilterDistanceCellIdentifier, forIndexPath: indexPath) as! FilterDistanceCell
			_distanceCell = cell
			_distanceCell.distance = FilterStats.sharedStats.radius
			cell.slider.addTarget(self, action: #selector(FilterViewController.radiusDidChanged), forControlEvents: UIControlEvents.ValueChanged)
			return cell
		}
        else {
            // Filter location cell
            let cell = tableView.dequeueReusableCellWithIdentifier(kFilterLocationCellIdentifier, forIndexPath: indexPath) as! FilterLocationCell
            cell.delegate = self
            
            if let location = DiscoverySearchLocationProvider.defaultProvider.selectedLocation {
                cell.setLocationName(location.address)
            }
            else {
                cell.setLocationName("Current location")
            }
            
            return cell
        }
		
    }
	
    public override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return FilterLocationCell.defaultHeight()
        }
        return FilterCell.defaultHeight
    }
}

//MARK: FilterLocationCellDelegate
extension FilterViewController: FilterLocationCellDelegate {
    func filterLocationCellButtonTapped(cell: FilterLocationCell) {
        // Go to map view controlelr 
        let mapViewController = BDFLocationPickerController()
        mapViewController.locationDelegate = self
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
}

//MARK: BDFLocationPickerControllerDelelgate
extension FilterViewController: BDFLocationPickerControllerDelegate {
    public func locationPickerControllerDidPickLocation(locationPickerController: BDFLocationPickerController, location: DiscoverySearchLocation?) {
        if let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0)) as? FilterLocationCell {
            if let location = location {
                cell.setLocationName(location.address)
            }
            else {
                cell.setLocationName("Current location")
            }
            
            // Call delegate
            delegate?.filterViewControllerDidChangeDiscoveryLocation(self, location: location)
        }
    }
}