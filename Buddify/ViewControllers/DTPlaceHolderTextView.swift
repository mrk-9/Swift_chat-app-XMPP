//
//  DTPlaceHolderTextView.swift
//  Buddify
//
//  Created by Tung Vo  on 06/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

public class DTPlaceHolderTextView: UITextView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addNotificationObservers()
        self.allowsEditingTextAttributes = true
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleNotification(_:)), name: UITextViewTextDidBeginEditingNotification, object: self)
    }
    
    public var placeHolderFont: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
    
    public var placeHolderTextColor: UIColor = UIColor.lightGrayColor()
    
    public var placeHolderText: String? {
        didSet {
            if _isEmpty {
                self.switchToPlaceholderMode()
            }
        }
    }
    
    // Normal font and text color
    private weak var _normalFont: UIFont?
    
    private weak var _normalTextColor: UIColor?
    
    // Override values
    override public var textColor: UIColor? {
        didSet {
            _normalTextColor = textColor
        }
    }
    
    override public var font: UIFont? {
        didSet {
            _normalFont = font
        }
    }
    
    override public var text: String! {
        get {
            if _isEmpty {
                return nil
            }
            
            return super.text
        }
        
        set {
            super.text = newValue
        }
    }
    
    // Flag if a text view has empty text
    private var _isEmpty: Bool = true
    
    // Notifications
    private func addNotificationObservers() {
        // Add notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleNotification(_:)), name: UITextViewTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.dynamicType.handleNotification(_:)), name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    private func removeNotificationObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidBeginEditingNotification, object: self)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextViewTextDidEndEditingNotification, object: self)
    }
    
    private func switchToPlaceholderMode() {
        if let _string = placeHolderText {
            self.attributedText = NSAttributedString(string: _string, attributes: [NSForegroundColorAttributeName: placeHolderTextColor, NSFontAttributeName: placeHolderFont])
        }
    }
    
    func handleNotification(notification: NSNotification) {
        if notification.object === self {
            if notification.name == UITextViewTextDidBeginEditingNotification {
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.textColor = self._normalTextColor
//                    self.font = self._normalFont
//                })
                
                // Begin editing, if it is in placeholder mode, switch to normal mode
                if _isEmpty == true {
                    //self.attributedText = nil
                    self.selectedRange = NSRange(location: 0, length: 0)
                }
                
                // Change even if text might be empty for text getter to work
                _isEmpty = false
            }
            else if notification.name == UITextViewTextDidEndEditingNotification {
                // End editing, if the text is empty, switch to placeholder mode
                if self.text == nil || self.text.isEmpty {
                    _isEmpty = true
                    self.switchToPlaceholderMode()
                }
                else {
                    _isEmpty = false
                }
            }
        }
    }
}
