//
//  SearchBar.swift
//  Buddify
//
//  Created by Vo Duc Tung on 31/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

protocol BDSearchBarDelegate: NSObjectProtocol {
    func searchBarDidChangeText(searchBar: BDSearchBar, text: String)
    func searchBarDidClearText(searchBar: BDSearchBar)
}

private let cancelButtonWidth: CGFloat = 60
private let cancelIconSize: CGFloat = 15

class BDSearchBar: UIView, UITextFieldDelegate {
    weak var delegate: BDSearchBarDelegate?
    
    private var textField: UITextField!
    private var cancelButton: HighLightButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    var placeHolder: String {
        set {
            textField.attributedPlaceholder = NSAttributedString.attributedStringFromFont(newValue, font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor().colorWithAlphaComponent(0.4), textAlignment: nil)
        }
        
        get {
            return textField.attributedPlaceholder?.string ?? ""
        }
    }
    
    private func commonInit() {
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        textField.delegate = self
        textField.tintColor = UIColor.whiteColor()
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.borderStyle = UITextBorderStyle.None
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.leftMargin, height: 0))
        textField.leftView = leftView
        textField.leftViewMode = .Always
        
        cancelButton = HighLightButton(frame: CGRect(x: textField.frame.size.width, y: 0, width: cancelButtonWidth, height: self.frame.size.height))
        cancelButton.setTitleColor(UIColor.clearColor(), forState: UIControlState.Disabled)
        cancelButton.addTarget(self, action: #selector(BDSearchBar.clearButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.titleLabel?.font = UIFont.appFont(CGFloat.normalFontSize)
        cancelButton.enabled = false
        cancelButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: (cancelButtonWidth - CGFloat.rightMargin - cancelIconSize), bottom: 0, right: CGFloat.rightMargin)
        cancelButton.setImage(UIImage.cancelIcon(size: CGSize(width: cancelIconSize, height: cancelIconSize), color: UIColor.whiteColor()), forState: UIControlState.Normal)
        cancelButton.setImage(UIImage.cancelIcon(size: CGSize(width: cancelIconSize, height: cancelIconSize), color: UIColor.clearColor()), forState: UIControlState.Disabled)
        self.addSubview(textField)
        
        textField.rightView = cancelButton
        textField.rightViewMode = .Always
    }
    
    var text: String? {
        set {
            textField.text = text
        }
        
        get {
            return textField.text
        }
    }
    
    internal func clearButtonTapped() {
        textField.text = ""
        cancelButton.enabled = false
        delegate?.searchBarDidClearText(self)
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override func isFirstResponder() -> Bool {
        return textField.isFirstResponder()
    }
    
    //MARK: UITextField
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {
            cancelButton.enabled = true
            return true
        }
        
        let newText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if newText.isEmpty {
            cancelButton.enabled = false
            delegate?.searchBarDidClearText(self)
        }
        else {
            cancelButton.enabled = true
            delegate?.searchBarDidChangeText(self, text: newText)
        }
        
        return true
    }
}
