//
//  InputToolBar.swift
//  Sportademo
//
//  Created by Tung Vo on 02/03/15.
//  Copyright (c) 2015 Tung Vo. All rights reserved.
//

import UIKit

private var textViewY : CGFloat = 10
private var textViewX : CGFloat = 10

private var sendButtonWidth : CGFloat = 44
private var sendButtonHeight : CGFloat = 44

//private let counterLabelWidth : CGFloat = 30
//private let counterLabelHeight : CGFloat = 30

class InputToolbar : UIView, HPGrowingTextViewDelegate {
    var textView : HPGrowingTextView!
    var sendButton : UIButton!
    //var counterLabel : UILabel!
    
    weak var delegate : HPGrowingTextViewDelegate?{
        set {
            textView.delegate = newValue
        }
        
        get{
            return textView.delegate
        }
    }
    
    var text: String! {
        set {
            textView.text = newValue
        }

        get {
            return textView.text
        }
    }
    
    override init(frame: CGRect) {
        print(frame)
        
        textView = HPGrowingTextView(frame: CGRect(x: textViewX, y: textViewY, width: frame.size.width - sendButtonWidth - textViewX*2, height: CGRectGetHeight(frame) - 2*textViewY))
        textView.isScrollable = true
        textView.keyboardType = UIKeyboardType.Twitter
        textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.maxHeight = 114
        textView.returnKeyType = UIReturnKeyType.Done
        textView.font = UIFont.appFont(CGFloat.normalFontSize)
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        textView.backgroundColor = UIColor.whiteColor()
        textView.placeholder = "Write your comment..."
        textView.clipsToBounds = true
        
        //Counter label
//        counterLabel = UILabel(frame: CGRect(x: CGRectGetWidth(frame) - sendButtonWidth - counterLabelWidth, y: (CGRectGetHeight(frame) - sendButtonHeight)/2, width: counterLabelWidth, height: sendButtonHeight))
//        counterLabel.font = UIFont.appFont(CGFloat.normalFontSize)
//        counterLabel.textColor = UIColor.lightGrayColor()
//        counterLabel.textAlignment = NSTextAlignment.Center
//        counterLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        
        sendButton = UIButton(type: UIButtonType.Custom)
        sendButton.frame = CGRect(x: CGRectGetWidth(frame) - sendButtonWidth, y: (CGRectGetHeight(frame) - sendButtonHeight)/2, width: sendButtonWidth, height: sendButtonHeight)
        sendButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        sendButton.setImage(UIImage.airPlaneIcon(size: CGSize(width: 20, height: 20), color: UIColor.appPurpleColor()), forState: UIControlState.Normal)
        sendButton.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(textView)
        self.addSubview(sendButton)
        
        print(textView.frame)
        print(sendButton.frame)
        ///self.addSubview(counterLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.frame.origin.y = textViewY
        //DTLog("offset y = \(textView.internalTextView.contentOffset.y)")
    }
    
    func addSendButtonTarGet(target : AnyObject?, action : Selector){
        sendButton.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}