//
//  KeyboardManager.swift
//  Buddify
//
//  Created by Vo Duc Tung on 03/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

class KeyboardManager: NSObject {
    weak var view: UIView?
    private var originalHeight: CGFloat
    var updateFrameAnimatedBlock: ((difference: CGFloat) -> Void)?
    
    init(view _view: UIView, originalHeight height: CGFloat) {
        originalHeight = height
        view = _view
        super.init()
    }
    
    func startObserving() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KeyboardManager.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    func stopObserving() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Keyboard frame change notification
    internal func keyboardWillChangeFrame(notification : NSNotification){
        guard let _view = view else {
            return
        }
        
        var userInfo = notification.userInfo!
        
        let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        
        
        var frame = _view.frame
        frame.size.height = (frameEnd.origin.y - CGFloat.screenHeight) + originalHeight
        
        //Change share bar frame
        
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntValue
        
        UIView.animateWithDuration(
            userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: UInt(curve)),
            animations: {
                _view.frame = frame
                self.updateFrameAnimatedBlock?(difference: frameEnd.origin.y - CGFloat.screenHeight)
            },
            completion: nil)
    }
}
