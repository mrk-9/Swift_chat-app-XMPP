//
//  ProfileEditViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 21/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import AsyncDisplayKit
import MSRangeSlider
import Models
import KVNProgress

private let kDoneButtonHeight: CGFloat = 70
private let kProfilePhotoSize: CGFloat = 80

private let kProfileEditingTitleCellIdentifier = "ProfileEditingTitleCellIdentifier"
private let kProfilePhotoCellIdentifier = "ProfilePhotoCellIdentifer"
private let kGenderCellIdentifier = "GenderCellIdentifer"
private let kBirthDateCellIdentifier = "BirthDateCellIdentifer"

class ProfileEditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let tableView: UITableView!
    
    private let _doneButton: UIButton!
	private var _gender: Int?
    private var _birthdate: NSDate?
    private var _profileImage: UIImage?
	private var _profileEditTitleCell: ProfileEditTitleCell!
    private var _photoCell: ProfileEditPhotoCell!
    private var _genderCell: UserGenderCell!
    private var _birthdateCell: ProfileEditAgeCell!
    
    init() {
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        tableView.backgroundColor = UIColor.appPurpleColor()
        tableView.scrollEnabled = false
		tableView.registerClass(ProfileEditTitleCell.self, forCellReuseIdentifier: kProfileEditingTitleCellIdentifier)
        tableView.registerClass(ProfileEditPhotoCell.self, forCellReuseIdentifier: kProfilePhotoCellIdentifier)
        tableView.registerClass(UserGenderCell.self, forCellReuseIdentifier: kGenderCellIdentifier)
        tableView.registerClass(ProfileEditAgeCell.self, forCellReuseIdentifier: kBirthDateCellIdentifier)
		
		
        _doneButton = UIButton(type: UIButtonType.Custom)
        _doneButton.backgroundColor = UIColor.appPinkColor()
        _doneButton.titleLabel?.font = UIFont.boldAppFont(25)
        _doneButton.setTitle("Get started", forState: UIControlState.Normal)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
		
        _doneButton.addTarget(self, action: #selector(ProfileEditViewController.doneButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		self.view.addSubview(_doneButton)

    }
	
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - kDoneButtonHeight)
        _doneButton.frame = CGRect(x: 0, y: self.view.bounds.height - kDoneButtonHeight, width: self.view.bounds.width, height: kDoneButtonHeight)
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.tableView.reloadData()
		self.navigationItem.hidesBackButton = true

	}
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //MARK: Methods
    func doneButtonTapped() {
		
		guard let profileImage = _profileImage else {
			let alertController = UIAlertController(title: "Info missing!", message: "Please select your profile image to proceed", preferredStyle: UIAlertControllerStyle.Alert)
			let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
				
			})
			alertController.addAction(cancelButton)
			self.presentViewController(alertController, animated: true, completion: nil)
			return
		}
		
        if _genderCell.selectedGender == .None {
            let alertController = UIAlertController(title: "Info missing!", message: "Please select your gender", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard let _birthdate = _birthdate else {
            let alertController = UIAlertController(title: "Info missing!", message: "Please select your birthday to proceed", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
		if _birthdate.age < 12 {
			let alertController = UIAlertController(title: "Alert!", message: "You have to be older than 12 years old to join Buddify.", preferredStyle: UIAlertControllerStyle.Alert)
			let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
				
			})
			alertController.addAction(cancelButton)
			self.presentViewController(alertController, animated: true, completion: nil)
			return
		}
		
		if _birthdate.age > 100 {
			let alertController = UIAlertController(title: "Alert!", message: "You should input a valid birthday to join Buddify.", preferredStyle: UIAlertControllerStyle.Alert)
			let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
				
			})
			alertController.addAction(cancelButton)
			self.presentViewController(alertController, animated: true, completion: nil)
			return
		}
		
		if _genderCell.selectedGender == .Male {
			self._gender = 0
		} else {
			self._gender = 1
		}
        
        // Show status
        KVNProgress.showWithStatus("Updating...")
		
        BDFAuthenticatedUser.currentUser.updateUserInformation(name: nil, username: nil, birthdate: _birthdate, bio: nil, gender: _genderCell.selectedGender, profileImage: profileImage, progressBlock: { (progress: NSProgress) in
            dispatch_async_main_queue({
                KVNProgress.updateProgress(CGFloat(progress.fractionCompleted), animated: true)
            })
            
            }, successBlock: { (user: User?) in
                // Update user and save
                if let user = user {
                    BDFAuthenticatedUser.currentUser.updateInformation(user)
                    BDFAuthenticatedUser.currentUser.save()
                }
                
                KVNProgress.showSuccessWithStatus("Success", completion: {
                    // Go to user view controller
                    let userViewController = UserTabbarController()
                    self.containerViewController?.presentViewController(userViewController, completion: nil)
                })
                
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Check error code
            if let _ = errorCode {
                // Show status
                KVNProgress.showErrorWithStatus("Updating failed. Please try again.")
            }
            else if let _ = statusCode {
                // Show status
                KVNProgress.showErrorWithStatus("Updating failed. Please try again.")
            }
            else {
                // Show status
                KVNProgress.showErrorWithStatus("Updating failed. Please try again.")
            }
        }
    }
	
    //MARK: ASTableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(kProfileEditingTitleCellIdentifier, forIndexPath: indexPath) as! ProfileEditTitleCell
            _profileEditTitleCell = cell
            return cell
        }
		if indexPath.row == 1 {
			let cell = tableView.dequeueReusableCellWithIdentifier(kProfilePhotoCellIdentifier, forIndexPath: indexPath) as! ProfileEditPhotoCell
			_photoCell = cell
			return cell
		}
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier(kGenderCellIdentifier, forIndexPath: indexPath) as! UserGenderCell
            _genderCell = cell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(kBirthDateCellIdentifier, forIndexPath: indexPath) as! ProfileEditAgeCell
            _birthdateCell = cell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.bounds.height - 64 - kDoneButtonHeight)/4
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 1 {
            //Image picker
            let alertController = UIAlertController.imagePickerAlertController(delegate: self, viewController: self)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if indexPath.row == 3 {
            //Date picker
            let datePickerViewController = AIDatePickerController.pickerWithDate(_birthdate ?? NSDate(), selectedBlock: { (date: NSDate!) -> Void in
                //Get the date
                if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? ProfileEditAgeCell {
                    self._birthdate = date
                    cell.setDate(date)
                }
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
                
                }, cancelBlock: { () -> Void in
                    //Do nothing
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        
                    })
            })
            self.presentViewController(datePickerViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ProfileEditPhotoCell {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                cell.profilePhotoView.image = image
                _profileImage = image
            }
            else {
                if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                    cell.profilePhotoView.image = image
                    _profileImage = image
                }
            }
        }
    }
}


private let textLabelX : CGFloat = CGFloat.leftMargin
private let textLabelY : CGFloat = 0
private let textLabelWidth : CGFloat = 150
private let textLabelHeight : CGFloat = 0
private let kFilterCellHeight : CGFloat = 100


class ProfileEditTitleCell: UITableViewCell {
	private var _title2: UILabel! = UILabel()

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.commonInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	private func commonInit() {
		self.textLabel!.text = "One more step!"
		self.textLabel?.textAlignment = NSTextAlignment.Center
		self.textLabel!.font = UIFont.boldAppFont(25)
		self.textLabel!.textColor = UIColor.whiteColor()
		
		self._title2.text = "Update your profile information"
		self._title2.textAlignment = NSTextAlignment.Center
		self._title2.font = UIFont.boldAppFont(20)
		self._title2.textColor = UIColor.whiteColor()
		
		self.backgroundColor = UIColor.appPurpleColor()
		self.selectionStyle = UITableViewCellSelectionStyle.None
		self.contentView.addSubview(_title2)
		
	}
	
	override func layoutSubviews() {
		self.textLabel!.frame = CGRect(x: textLabelX, y: kFilterCellHeight/2 , width: self.frame.size.width - textLabelX*2, height: 25)
		self._title2.frame = CGRect(x: textLabelX, y: kFilterCellHeight/2 + 30, width: self.frame.size.width - textLabelX*2, height: 20)
	}
}

//MARK: Customized UITableView cells
private let kLabelHeight: CGFloat = 20

class ProfileEditAgeCell: FilterCell {
	let dayLabel: UILabel
	let monthLabel: UILabel
	let yearLabel: UILabel
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		dayLabel = UILabel()
		dayLabel.textColor = UIColor.appPurpleColor()
		dayLabel.textAlignment = NSTextAlignment.Center
		dayLabel.font = UIFont.boldAppFont(20)
		
		monthLabel = UILabel()
		monthLabel.textColor = UIColor.appPurpleColor()
		monthLabel.textAlignment = NSTextAlignment.Center
		monthLabel.font = UIFont.boldAppFont(20)
		
		yearLabel = UILabel()
		yearLabel.textColor = UIColor.appPurpleColor()
		yearLabel.textAlignment = NSTextAlignment.Center
		yearLabel.font = UIFont.boldAppFont(20)
		
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.contentView.addSubview(dayLabel)
		self.contentView.addSubview(monthLabel)
		self.contentView.addSubview(yearLabel)
		self.setDate(NSDate())
		self.textLabel?.text = "Birthdate"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		let size = self.bounds.size
		yearLabel.frame = CGRect(x: size.width - 60 - CGFloat.rightMargin, y: (size.height - kLabelHeight)/2, width: 60, height: kLabelHeight)
		monthLabel.frame = CGRect(x: yearLabel.frame.origin.x - CGFloat.rightMargin - 50, y: (size.height - kLabelHeight)/2, width: 50, height: kLabelHeight)
		dayLabel.frame = CGRect(x: monthLabel.frame.origin.x - CGFloat.rightMargin - 40, y: (size.height - kLabelHeight)/2, width: 40, height: kLabelHeight)
		
	}
	
	func setDate(date: NSDate) {
		if let customDate = TimeUtility.sharedInstance.customDateFromDate(date) {
			dayLabel.text = String(customDate.day)
			monthLabel.text = customDate.monthString()
			yearLabel.text = String(customDate.year)
			
			self.descriptionLabel.text = String(date.age)
		}
	}
}


//MARK: Nodes

private let kMaleFemaleButtonSpacing: CGFloat = 40
private let kDateElementsSpacing: CGFloat = 30
private let kLeftInsetSpacing: CGFloat = 23
private let kRightInsetSpacing: CGFloat = 23
private let kCellNodeHeight: CGFloat = CGFloat.screenHeight*0.225
private let KGetStartedNodeHeight: CGFloat = CGFloat.screenHeight*0.1
private let kSignUpSettingNodeHeight: CGFloat = 136
private let kButtonSize: CGFloat = 40
//private let kProfilePhotoRightSpacing: CGFloat = (kButtonSize*2 + kMaleFemaleButtonSpacing + kRightInsetSpacing - kProfilePhotoSize)/2 - kRightInsetSpacing

class ProfileEditTitleNode: ASCellNode {
	var title1Label: ASTextNode!
	var title2Label: ASTextNode!

	override init() {
		super.init()
		
		title1Label = ASTextNode()
		title1Label.layerBacked = true
		title1Label.attributedString = NSAttributedString.attributedStringFromFont("ALMOST THERE", font: UIFont.boldAppFont(23), textColor: UIColor.whiteColor(), textAlignment: nil)
		self.addSubnode(title1Label)
		
		title2Label = ASTextNode()
		title2Label.layerBacked = true
		title2Label.attributedString = NSAttributedString.attributedStringFromFont("LET WE SET THING UP FOR YOU", font: UIFont.boldAppFont(20), textColor: UIColor.whiteColor(), textAlignment: nil)
		self.addSubnode(title2Label)
		self.backgroundColor = UIColor.appPurpleColor()
		self.selectionStyle = .None
	}
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		self.alignSelf = .Stretch
		let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [title1Label, title2Label])
		stack.alignSelf = .Stretch
		let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 70, left: kLeftInsetSpacing, bottom: 30, right: kRightInsetSpacing), child: stack)
		insetSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: kCellNodeHeight)
		return ASStaticLayoutSpec(children: [insetSpec])
	}
}

internal class ProfileSettingsNode: ASCellNode {
    var titleLabel: ASTextNode!
    
    override init() {
        super.init()
        titleLabel = ASTextNode()
        titleLabel.layerBacked = true
        titleLabel.preferredFrameSize.height = kCellNodeHeight
        self.addSubnode(titleLabel)
        self.backgroundColor = UIColor.appPurpleColor()
        self.selectionStyle = .None
    }
    
    func setTitle(title: String) {
        titleLabel.attributedString = NSAttributedString.attributedStringFromFont(title, font: UIFont.boldAppFont(23), textColor: UIColor.whiteColor(), textAlignment: nil)
    }
}

enum GenderSelection: Int {
    case None = 0
    case Male = 1
    case Female = 2
    case Both = 3
}

internal class ProfileGenderNode: ProfileSettingsNode {
    var maleButton: ASHighLightButton!
    var femaleButton: ASHighLightButton!
    var multipleSelection = false
    var changeGenderBlock: ((Bool) -> Void)?
    var genderText : ASButtonNode!
    
    var selectedGender: BDFUserGender {
        get {
            if maleButton.selected && femaleButton.selected {
                return .Both
            }
            else if maleButton.selected {
                return .Male
            }
            else if femaleButton.selected {
                return .Female
            }
            return .Both
        }
        
        set {
            if newValue == .Both {
                maleButton.selected = true
                femaleButton.selected = true
            }
            else if newValue == .Male {
                maleButton.selected = true
                femaleButton.selected = false
            }
            else if newValue == .Female {
                maleButton.selected = false
                femaleButton.selected = true
            }
            else {
                maleButton.selected = true
                femaleButton.selected = true
            }
        }
    }
    
    private let buttonSize: CGFloat = kButtonSize
    
    override init() {
		super.init()

		self.setTitle("GENDER")

		genderText = ASButtonNode()
		genderText.setTitle("MALE", withFont: UIFont.boldAppFont(CGFloat.smallFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
		genderText.setTitle("FEMALE", withFont: UIFont.boldAppFont(CGFloat.smallFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Selected)
		genderText.setTitle("?", withFont: UIFont.boldAppFont(CGFloat.smallFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Disabled)
		genderText.enabled = false
		self.addSubnode(genderText)
		
        //Male button
        maleButton = ASHighLightButton()
        maleButton.setImage(UIImage.maleIcon(size: CGSize(width: 35, height: 35), color: UIColor.whiteColor()), forState: ASControlState.Selected)
        maleButton.setImage(UIImage.maleIcon(size: CGSize(width: 35, height: 35), color: UIColor(white: 1.0, alpha: 0.3)), forState: ASControlState.Normal)
		self.addSubnode(maleButton)

        //Female button
        femaleButton = ASHighLightButton()
        femaleButton.setImage(UIImage.femaleIcon(size: CGSize(width: 28, height: 40), color: UIColor.whiteColor()), forState: ASControlState.Selected)
        femaleButton.setImage(UIImage.femaleIcon(size: CGSize(width: 28, height: 40), color: UIColor(white: 1.0, alpha: 0.3)), forState: ASControlState.Normal)
        self.addSubnode(femaleButton)
		
		
        maleButton.addTarget(self, action: #selector(ProfileGenderNode.buttonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
        femaleButton.addTarget(self, action: #selector(ProfileGenderNode.buttonTapped(_:)), forControlEvents: ASControlNodeEvent.TouchUpInside)
    }
    
    func buttonTapped(button: ASButtonNode) {
        if !multipleSelection {
            //Can only select 1 at a time
            button.selected = true
            
            if button == femaleButton {
                maleButton.selected = false
                changeGenderBlock?(false)
            }
            else {
                femaleButton.selected = false
                changeGenderBlock?(true)
            }
        }
        else {
            //Can select multiple gender
            var otherButton: ASButtonNode
            if button == femaleButton {
                otherButton = maleButton
            }
            else {
                otherButton = femaleButton
            }
            
            if !button.selected || otherButton.selected {
                button.selected = !button.selected
            }
        }
    }
    
    internal override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        maleButton.sizeRange = ASRelativeSizeRange(width: kButtonSize, height: kButtonSize)
        femaleButton.sizeRange = ASRelativeSizeRange(width: kButtonSize, height: kButtonSize)
        
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
		
		let titleStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start	, alignItems: ASStackLayoutAlignItems.Start, children: [titleLabel, genderText])

        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: kMaleFemaleButtonSpacing, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [ASStaticLayoutSpec(children: [titleStack]), spacer, ASStaticLayoutSpec(children: [maleButton]), ASStaticLayoutSpec(children: [femaleButton])])
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: kLeftInsetSpacing, bottom: 0, right: kRightInsetSpacing), child: horizontalStack)
        
        insetSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: kCellNodeHeight)
        
        return ASStaticLayoutSpec(children: [insetSpec])
    }
    
    override func layout() {
        super.layout()
    }
}

internal class ProfileBirthdayNode: ProfileSettingsNode {
    let dayButton: ASTextNode!
    let monthButton: ASTextNode!
    let yearButton: ASTextNode!
	var ageText: ASButtonNode!
    private var constrainedSize: ASSizeRange?
    
    override init() {
        dayButton = ASTextNode()
        dayButton.layerBacked = true
        monthButton = ASTextNode()
        monthButton.layerBacked = true
        yearButton = ASTextNode()
        yearButton.layerBacked = true
        
        super.init()
        self.setTitle("AGE")
		
		//age text
		ageText = ASButtonNode()
		ageText.setTitle("?", withFont: UIFont.boldAppFont(CGFloat.smallFontSize), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
		self.addSubnode(ageText)
		
		//set default date
		let dataString = "January 1, 1999" as String
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		
		// convert string into date
		let dateValue = dateFormatter.dateFromString(dataString) as NSDate!
		self.setDate(dateValue)
        self.addSubnode(dayButton)
        self.addSubnode(monthButton)
        self.addSubnode(yearButton)
    }
    
    internal override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        self.constrainedSize = constrainedSize
		
		let titleStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Start, children: [titleLabel, ageText])

        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 20, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [titleStack, spacer, dayButton, monthButton, yearButton])
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: kLeftInsetSpacing, bottom: 0, right: kRightInsetSpacing), child: horizontalStack)
        
        insetSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: kCellNodeHeight)
        
        return ASStaticLayoutSpec(children: [insetSpec])
    }
    
    func setDate(date: NSDate) {
        if let customDate = TimeUtility.sharedInstance.customDateFromDate(date) {
            dayButton.attributedString = NSAttributedString.attributedStringFromFont(String(customDate.day), font: UIFont.boldAppFont(20), textColor: UIColor.whiteColor(), textAlignment: nil)
            monthButton.attributedString = NSAttributedString.attributedStringFromFont(customDate.monthString(), font: UIFont.boldAppFont(20), textColor: UIColor.whiteColor(), textAlignment: nil)
            yearButton.attributedString = NSAttributedString.attributedStringFromFont(String(customDate.year), font: UIFont.boldAppFont(20), textColor: UIColor.whiteColor(), textAlignment: nil)
            self.setNeedsLayout()
        }
    }
}

private let kSliderWidth: CGFloat = 200
private let kSliderHeight: CGFloat = 40

class ProfileEditSlider: ProfileSettingsNode {
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        titleLabel.spacingBefore = kLeftInsetSpacing
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [titleLabel])
		
        horizontalStack.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: kCellNodeHeight)
        
        return ASStaticLayoutSpec(children: [horizontalStack])
    }
}

class ProfileEditAgeRangeSlider: ProfileEditSlider {
    internal var slider = MSRangeSlider(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: kSliderWidth, height: kSliderHeight)))
    
    var minAge: Int {
        set {
            slider.minimumValue = CGFloat(newValue)
        }
        
        get {
            return Int(slider.minimumValue)
        }
    }
    
    var maxAge: Int {
        set {
            slider.maximumValue = CGFloat(newValue)
        }
        
        get {
            return Int(slider.maximumValue)
        }
    }
    
    override init() {
        super.init()
        slider.tintColor = UIColor.whiteColor()
        self.setTitle("Age")
        slider.minimumValue = 12
        slider.maximumValue = 100
        slider.fromValue = 16
        slider.toValue = 40
    }
    
    override func layout() {
        super.layout()
        self.view.addSubview(slider)
        let bounds = self.bounds
        slider.frame = CGRect(origin: CGPoint(x: bounds.size.width - kLeftInsetSpacing - kSliderWidth, y: (bounds.size.height - kSliderHeight)/2), size: CGSize(width: kSliderWidth, height: kSliderHeight))
    }
}

class ProfilePhotoNode: ProfileSettingsNode {
    let profileImageNode: ASImageNode
    
    override init() {
        profileImageNode = ASImageNode()
        profileImageNode.layerBacked = true
        profileImageNode.imageModificationBlock = roundedImageMotificationBlock()
        
        super.init()
        self.setTitle("PROFILE PICTURE")
        self.addSubnode(profileImageNode)
        self.backgroundColor = UIColor.appPurpleColor()
    }
    
    internal override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        profileImageNode.preferredFrameSize = CGSize(width: kProfilePhotoSize, height: kProfilePhotoSize)
        profileImageNode.cornerRadius = kProfilePhotoSize/2
        profileImageNode.borderColor = UIColor.whiteColor().CGColor
        profileImageNode.borderWidth = 2
        
        let spacer = ASLayoutSpec()
        spacer.flexGrow = true
        let horizontalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0, justifyContent: ASStackLayoutJustifyContent.Start, alignItems: ASStackLayoutAlignItems.Center, children: [titleLabel, spacer, profileImageNode])
        
        let insetSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: kLeftInsetSpacing, bottom: 0, right: kRightInsetSpacing), child: horizontalStack)
        
        insetSpec.sizeRange = ASRelativeSizeRange(width: constrainedSize.max.width, height: kCellNodeHeight)
        
        return ASStaticLayoutSpec(children: [insetSpec])
    }
}

class ProfileEditDistanceSlider: ProfileEditSlider {
    internal var slider = UISlider()
    
    var distance: Int {
        set {
            slider.value = Float(newValue)
        }
        
        get {
            return Int(slider.value)
        }
    }
    
    override init() {
        super.init()
        self.setTitle("Distance")
        slider.minimumValue = 1
        slider.maximumValue = 200
        slider.value = 10
        slider.tintColor = UIColor.whiteColor()
    }
    
    override func layout() {
        super.layout()
        self.view.addSubview(slider)
        let bounds = self.bounds
        slider.frame = CGRect(origin: CGPoint(x: bounds.size.width - kLeftInsetSpacing - kSliderWidth, y: (bounds.size.height - kSliderHeight)/2), size: CGSize(width: kSliderWidth, height: kSliderHeight))
    }
}
