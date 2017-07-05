//
//  FilterCell.swift
//  Buddify
//
//  Created by Admin on 12/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import MSRangeSlider
import Models
import AsyncDisplayKit

private let textLabelX : CGFloat = CGFloat.leftMargin
private let textLabelY : CGFloat = 0
private let textLabelWidth : CGFloat = 150
private let textLabelHeight : CGFloat = 0

private let kSliderWidth: CGFloat = 200
private let kSliderHeight: CGFloat = 40
private let kFilterCellHeight: CGFloat = 80

private let kCancelIconSize : CGFloat = 15
private let kCancelButtonSize : CGFloat = 30
private let kCancelButtonY : CGFloat = 33

//MARK: FilterCell
class FilterCell: UITableViewCell {
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.textLabel?.font = UIFont.boldAppFont(CGFloat.bigFontSize)
        self.textLabel?.textColor = UIColor.appPurpleColor()
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.descriptionLabel.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        self.descriptionLabel.textColor = UIColor.appPurpleColor()
        self.contentView.addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        self.textLabel?.frame = CGRect(x: textLabelX, y: 0, width: textLabelWidth, height: self.frame.size.height)
        self.descriptionLabel.frame = CGRect(x: textLabelX, y: self.frame.size.height/2 + 15, width: textLabelWidth, height: 20)
    }
    
    class var defaultHeight: CGFloat {
        return kFilterCellHeight
    }
}

class FilterAgeCell: FilterCell {
    internal var slider = MSRangeSlider(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: kSliderWidth, height: kSliderHeight)))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    var minAge: Int {
        set {
            slider.fromValue = CGFloat(newValue)
        }
        
        get {
            return Int(slider.fromValue)
        }
    }
    
    var maxAge: Int {
        set {
            slider.toValue = CGFloat(newValue)
        }
        
        get {
            return Int(slider.toValue)
        }
    }
    
    private override func commonInit() {
        super.commonInit()
        textLabel?.text = "Age"
        descriptionLabel.text = "16 - 20"
        
        slider.minimumValue = 12
        slider.maximumValue = 100
        slider.minimumInterval = 1
        slider.selectedTrackTintColor = UIColor.appPinkColor()
        slider.trackTintColor = UIColor.lightGrayColor()
        //slider.thumbTintColor = UIColor.whiteColor()
        
        self.contentView.addSubview(slider)
        slider.frame = CGRect(origin: CGPoint(x: CGFloat.screenWidth - CGFloat.leftMargin - kSliderWidth, y: (kFilterCellHeight - kSliderHeight)/2), size: CGSize(width: kSliderWidth, height: kSliderHeight))
    }
}

class FilterDistanceCell: FilterCell {
    internal var slider = UISlider(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: kSliderWidth, height: kSliderHeight)))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    var distance: Int {
        set {
            descriptionLabel.text = "\(newValue)km"
            slider.value = Float(newValue)
        }
        
        get {
            return Int(slider.value)
        }
    }
    
    private override func commonInit() {
        super.commonInit()
        textLabel?.text = "Distance"
        
        slider.minimumValue = 1
        slider.maximumValue = 200
        slider.minimumTrackTintColor = UIColor.appPinkColor()
        //slider.maximumTrackTintColor = UIColor.grayColor()
        //slider.thumbTintColor = UIColor.grayColor()
        slider.value = 10
        descriptionLabel.text = "10km"
        self.contentView.addSubview(slider)
        slider.frame = CGRect(origin: CGPoint(x: CGFloat.screenWidth - CGFloat.leftMargin - kSliderWidth, y: (kFilterCellHeight - kSliderHeight)/2), size: CGSize(width: kSliderWidth, height: kSliderHeight))
    }
}

class FilterGenderCell: FilterCell {
    var maleButton: UIButton!
    var femaleButton: UIButton!
    var bothButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.text = "Gender"
        
        //Male button
        maleButton = UIButton(type: UIButtonType.Custom)
        self.addSubview(maleButton)
        
        //Female button
        femaleButton = UIButton(type: UIButtonType.Custom)
        self.addSubview(femaleButton)
        
        //Male & Female button
        bothButton = UIButton(type: UIButtonType.Custom)
        self.addSubview(bothButton)
        
        let normalFont = UIFont.boldAppFont(CGFloat.normalFontSize)
        let selectedFont = UIFont.boldAppFont(CGFloat.normalFontSize)
        let normalTextColor = UIColor.appPurpleColor()
        let selectedTextColor = UIColor.whiteColor()
        let normalBackgroundColor = UIColor.whiteColor()
        let selectedBackgroundColor = UIColor.appPurpleColor()
        
        maleButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Men", font: normalFont, textColor: normalTextColor, textAlignment: nil), forState: UIControlState.Normal)
        maleButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Men", font: selectedFont, textColor: selectedTextColor, textAlignment: nil), forState: UIControlState.Selected)
        maleButton.setBackgroundImage(UIImage.imageWithColor(normalBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Normal)
        maleButton.setBackgroundImage(UIImage.imageWithColor(selectedBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Selected)
        
        femaleButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Women", font: normalFont, textColor: normalTextColor, textAlignment: nil), forState: UIControlState.Normal)
        femaleButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Women", font: selectedFont, textColor: selectedTextColor, textAlignment: nil), forState: UIControlState.Selected)
        femaleButton.setBackgroundImage(UIImage.imageWithColor(normalBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Normal)
        femaleButton.setBackgroundImage(UIImage.imageWithColor(selectedBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Selected)
        
        bothButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Both", font: normalFont, textColor: normalTextColor, textAlignment: nil), forState: UIControlState.Normal)
        bothButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Both", font: selectedFont, textColor: selectedTextColor, textAlignment: nil), forState: UIControlState.Selected)
        bothButton.setBackgroundImage(UIImage.imageWithColor(normalBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Normal)
        bothButton.setBackgroundImage(UIImage.imageWithColor(selectedBackgroundColor, size: CGSize(width: 1, height: 1)), forState: UIControlState.Selected)
        
        maleButton.addTarget(self, action: #selector(FilterGenderCell.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        femaleButton.addTarget(self, action: #selector(FilterGenderCell.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        bothButton.addTarget(self, action: #selector(FilterGenderCell.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        let maleWidth = "Male".widthInHeight(20, font: UIFont.boldAppFont(CGFloat.normalFontSize))
        let femaleWidth = "Female".widthInHeight(20, font: UIFont.boldAppFont(CGFloat.normalFontSize))
        let bothWidth = "Both".widthInHeight(20, font: UIFont.boldAppFont(CGFloat.normalFontSize))
        
        let margin: CGFloat = 20
        let buttonHeight: CGFloat = 35
        
        bothButton.frame.size = CGSize(width: bothWidth + margin, height: buttonHeight)
        maleButton.frame.size = CGSize(width: maleWidth + margin, height: buttonHeight)
        femaleButton.frame.size = CGSize(width: femaleWidth + margin, height: buttonHeight)
        
        bothButton.layer.cornerRadius = buttonHeight/2
        bothButton.layer.masksToBounds = true
        maleButton.layer.cornerRadius = buttonHeight/2
        maleButton.layer.masksToBounds = true
        femaleButton.layer.cornerRadius = buttonHeight/2
        femaleButton.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Button Y position
        let y = (self.frame.size.height - bothButton.frame.size.height)/2
        
        //Now when we already have size of each button from viewDidLoad, it's time to calculate buttons' x values
        let openSpace = self.frame.size.width - self.textLabel!.frame.size.width - self.textLabel!.frame.origin.x
        
        //Calculate space would be between buttons (--button--button--button--)
        //let spaceBetween = (openSpace - bothButton.frame.size.width - maleButton.frame.size.width - femaleButton.frame.size.width)/4
        let spaceBetween: CGFloat = 20 // Spacing between button
        
        //Now give position of each button
        bothButton.frame.origin = CGPoint(x: self.frame.size.width - spaceBetween - bothButton.frame.size.width, y: y)
        maleButton.frame.origin = CGPoint(x: bothButton.frame.origin.x - spaceBetween - maleButton.frame.size.width, y: y)
        femaleButton.frame.origin = CGPoint(x: maleButton.frame.origin.x - spaceBetween - femaleButton.frame.size.width, y: y)
    }
    
    func buttonTapped(button: ASButtonNode) {
        var aButton: UIButton
        var anotherButton: UIButton
        
        if button == self.bothButton {
            aButton = self.maleButton
            anotherButton = self.femaleButton
        }
        else if button == self.maleButton {
            aButton = self.femaleButton
            anotherButton = self.bothButton
        }
        else {
            aButton = self.bothButton
            anotherButton = self.maleButton
        }
        
        
        if button.selected && anotherButton.selected && aButton.selected {
            aButton.selected = false
            anotherButton.selected = false
            
        } else if !button.selected {
            button.selected = true
            aButton.selected = false
            anotherButton.selected = false
        }
        
        //Update description label
        let selectedGender = self.selectedGender
        self.selectedGender = selectedGender
    }
    
    var selectedGender: BDFUserGender {
        set {
            if newValue == . Male {
                maleButton.selected = true
                femaleButton.selected = false
                bothButton.selected = false
                self.descriptionLabel.text = "Men"
            }
            else if newValue == .Female {
                maleButton.selected = false
                femaleButton.selected = true
                bothButton.selected = false
                self.descriptionLabel.text = "Women"
            }
            else if newValue == .Both {
                maleButton.selected = false
                femaleButton.selected = false
                bothButton.selected = true
                self.descriptionLabel.text =  "Men and women"
            }
            
        }
        
        get {
            if bothButton.selected{
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
    }
    
}

// MARK UserGenderCell

private let kGenderButtonSize: CGFloat = 40
private let bothButtonX : CGFloat = maleButtonX - kGenderButtonSize - 20
private let maleButtonX : CGFloat = femaleButtonX - kGenderButtonSize - 20

private let femaleButtonX : CGFloat = CGFloat.screenWidth - CGFloat.rightMargin - kGenderButtonSize


///
/// Class UserGenderCell.
/// Used in ProfileEditViewController
///
class UserGenderCell: FilterCell {
    var maleButton: UIButton!
    var femaleButton: UIButton!
    
    var changeGenderBlock: ((Bool) -> Void)?
    
    var selectedGender: BDFUserGender {
        set {
            if newValue == . Male {
                maleButton.selected = true
                femaleButton.selected = false
                self.descriptionLabel.text = "Male"
            }
            else if newValue == .Female {
                maleButton.selected = false
                femaleButton.selected = true
                self.descriptionLabel.text = "Female"
            }
                
            else {
                maleButton.selected = false
                femaleButton.selected = false
                self.descriptionLabel.text = ""
            }
        }
        
        get {
            if maleButton.selected {
                return .Male
            }
            else if femaleButton.selected {
                return .Female
            }
            return .Both
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.text = "Gender"
        
        //Male button
        maleButton = UIButton(type: UIButtonType.Custom)
        maleButton.setImage(UIImage.maleIcon(size: CGSize(width: 35, height: 35), color: UIColor.appPurpleColor()), forState: UIControlState.Selected)
        maleButton.setImage(UIImage.maleIcon(size: CGSize(width: 35, height: 35), color: UIColor.appPurpleColor().colorWithAlphaComponent(0.5)), forState: UIControlState.Normal)
        maleButton.imageEdgeInsets = UIEdgeInsetsZero
        self.addSubview(maleButton)
        
        //Female button
        femaleButton = UIButton(type: UIButtonType.Custom)
        femaleButton.imageEdgeInsets.top = 5
        femaleButton.imageEdgeInsets.bottom = -5
        femaleButton.setImage(UIImage.femaleIcon(size: CGSize(width: 38, height: 38), color: UIColor.appPurpleColor()), forState: UIControlState.Selected)
        femaleButton.setImage(UIImage.femaleIcon(size: CGSize(width: 38, height: 38), color: UIColor.appPurpleColor().colorWithAlphaComponent(0.5)), forState: UIControlState.Normal)
        self.addSubview(femaleButton)
        
        maleButton.addTarget(self, action: #selector(FilterGenderCell.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        femaleButton.addTarget(self, action: #selector(FilterGenderCell.buttonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maleButton.frame = CGRect(origin: CGPoint(x: maleButtonX, y: (self.frame.size.height - kGenderButtonSize)/2), size: CGSize(width: kGenderButtonSize, height: kGenderButtonSize))
        femaleButton.frame = CGRect(origin: CGPoint(x: femaleButtonX, y: (self.frame.size.height - kGenderButtonSize)/2), size: CGSize(width: kGenderButtonSize, height: kGenderButtonSize))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func buttonTapped(button: ASButtonNode) {
        
        button.selected = true
        
        if button == femaleButton {
            maleButton.selected = false
            changeGenderBlock?(false)
            self.selectedGender = .Female
        }
        else {
            femaleButton.selected = false
            changeGenderBlock?(true)
            self.selectedGender = .Male
        }
    }
    
}

private let kProfilePhotoSize: CGFloat = 80

class ProfileEditPhotoCell: FilterCell {
    let profilePhotoView: UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        profilePhotoView = UIImageView()
        profilePhotoView.layer.cornerRadius = kProfilePhotoSize/2
        profilePhotoView.layer.borderColor = UIColor.appPurpleColor().CGColor
        profilePhotoView.layer.borderWidth = 2
        profilePhotoView.layer.masksToBounds = true
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = "Profile photo"
        self.contentView.addSubview(profilePhotoView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        profilePhotoView.frame = CGRect(x: CGRectGetWidth(bounds) - CGFloat.rightMargin - kProfilePhotoSize, y: (CGRectGetHeight(bounds) - kProfilePhotoSize)/2, width: kProfilePhotoSize, height: kProfilePhotoSize)
    }
}