//
//  SignInViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 23/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//
import AsyncDisplayKit
import RNLoadingButton_Swift
import LoremIpsum
import Models

class SignInViewController: ASViewController, UITextFieldDelegate {
	private let _signInNode = SignInNode()
	private let _passwordTextField = UITextField()
	private let _usernameTextField = UITextField()
	private let _questionButton = UIButton()
	private let _loadingButton = RNLoadingButton()

	init() {
        super.init(node: _signInNode)
	}

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
	
    override func loadView() {
        super.loadView()
		self.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		
		//Email textfield
		_usernameTextField.delegate = self
		_usernameTextField.font = UIFont.appFont(CGFloat.normalFontSize)
		_usernameTextField.borderStyle = UITextBorderStyle.None
		_usernameTextField.textColor = UIColor.appPurpleColor()
		_usernameTextField.autocorrectionType = UITextAutocorrectionType.No
		_usernameTextField.autocapitalizationType = UITextAutocapitalizationType.None
		_usernameTextField.keyboardType = UIKeyboardType.Default
		_usernameTextField.returnKeyType = UIReturnKeyType.Next
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		_usernameTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
		self.view.addSubview(_usernameTextField)
		
		//Password textfield
		_passwordTextField.delegate = self
		_passwordTextField.secureTextEntry = true
		_passwordTextField.font = UIFont.appFont(CGFloat.normalFontSize)
		_passwordTextField.borderStyle = UITextBorderStyle.None
		_passwordTextField.textColor = UIColor.appPurpleColor()
		_passwordTextField.autocorrectionType = UITextAutocorrectionType.No
        _passwordTextField.autocapitalizationType = UITextAutocapitalizationType.None
		_passwordTextField.keyboardType = UIKeyboardType.Default
		_passwordTextField.returnKeyType = UIReturnKeyType.Done
		_passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		_passwordTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
		self.view.addSubview(_passwordTextField)
		
		//Question button
		_questionButton.frame = CGRect(x: 0, y: 0, width: kQuestionButtonSize, height: kQuestionButtonSize)
		_questionButton.setImage(UIImage.questionMarkIcon(size: CGSize(width: kQuestionButtonSize, height: kQuestionButtonSize), color: UIColor.appPurpleColor()), forState: .Normal)
		_questionButton.setImage(UIImage.questionMarkIcon(size: CGSize(width: kQuestionButtonSize, height: kQuestionButtonSize), color: UIColor.appPurpleColor().colorWithAlphaComponent(0.3)), forState: .Highlighted)
		_questionButton.userInteractionEnabled = true
		_questionButton.addTarget(self, action: #selector(SignInViewController.questionButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		_passwordTextField.rightView = _questionButton
		_passwordTextField.rightViewMode = UITextFieldViewMode.Always
		
		//Password textfield
		_usernameTextField.delegate = self
		_usernameTextField.font = UIFont.appFont(CGFloat.normalFontSize)
		_usernameTextField.borderStyle = UITextBorderStyle.None
        _usernameTextField.keyboardType = UIKeyboardType.EmailAddress
		_usernameTextField.textColor = UIColor.appPurpleColor()
		_usernameTextField.autocorrectionType = UITextAutocorrectionType.No
        _usernameTextField.autocapitalizationType = UITextAutocapitalizationType.None
		_usernameTextField.returnKeyType = UIReturnKeyType.Next
		_usernameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		_usernameTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
		self.view.addSubview(_usernameTextField)
		
		//button methods
        _signInNode._forgotPasswordButton.addTarget(self, action: #selector(SignInViewController.forgotPasswordButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		_signInNode._createAccountButton.addTarget(self, action: #selector(SignInViewController.createNewAccountButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		_signInNode._signInWithFacebookButton.addTarget(self, action: #selector(SignInViewController.signInWithFacebookButtonTapped), forControlEvents: ASControlNodeEvent.TouchUpInside)
		
		//loading button
		_loadingButton.enabled = false
		_loadingButton.loading = false
		_loadingButton.activityIndicatorAlignment = .Center
		_loadingButton.setActivityIndicatorStyle(UIActivityIndicatorViewStyle.White, state: UIControlState.Normal)
        _loadingButton.hideTextWhenLoading = true
		_loadingButton.titleLabel?.textAlignment = .Center
		_loadingButton.titleLabel?.font = UIFont.boldAppFont(18)
		_loadingButton.layer.cornerRadius = kButtonVerticalInset/5
		_loadingButton.titleLabel?.textColor = UIColor.whiteColor()
		_loadingButton.setTitle("GO", forState: UIControlState.Normal)
		_loadingButton.setTitle("GO", forState: UIControlState.Highlighted)
		_loadingButton.setTitle("GO", forState: UIControlState.Disabled)
		_loadingButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forState: UIControlState.Normal)
		_loadingButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor().colorWithAlphaComponent(0.5)), forState: UIControlState.Highlighted)
		_loadingButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor().colorWithAlphaComponent(0.7)), forState: UIControlState.Disabled)
		_loadingButton.addTarget(self, action: #selector(SignInViewController.signInButtonTapped), forControlEvents: .TouchUpInside)
		self.view.addSubview(_loadingButton)
    }
	
	override func layoutSublayersOfLayer(layer: CALayer) {
		super.layoutSublayersOfLayer(layer)
		
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		_usernameTextField.frame = _signInNode._usernameTextField.frame
		_passwordTextField.frame = _signInNode._passwordTextField.frame
		_usernameTextField.frame.size.height = 20
		_passwordTextField.frame.size.height = 20

		_questionButton.frame = CGRect(x: _passwordTextField.frame.size.width - kQuestionButtonSize, y: 0, width: _passwordTextField.frame.size.height, height: _passwordTextField.frame.size.height)
		
		_loadingButton.frame = _signInNode._signInButton.frame

	}
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
		
		//Exit bar button
		let exitButton = UIButton()
		exitButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
		exitButton.setImage(UIImage.backIcon(size: CGSize(width: 30, height: 20), color: UIColor.appPurpleColor()), forState: UIControlState.Normal)
		exitButton.addTarget(self, action: #selector(SignUpViewController.exitButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		let leftBarButton = UIBarButtonItem()
		leftBarButton.customView = exitButton
		self.navigationItem.leftBarButtonItem = leftBarButton
		
		//let backButtonImage = UIImage.backIcon(size: CGSize(width: 30, height: 20), color: UIColor.appPurpleColor()).stretchableImageWithLeftCapWidth(20, topCapHeight: 20)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.translucent = true
		self.navigationItem.hidesBackButton = false
    }
	
	internal func exitButtonTapped() {
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignInViewController.keyboardDidChangeFrame(_:)), name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Remove notifications
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    //MARK: Notifications handler
    func keyboardDidChangeFrame(notification: NSNotification) {
        
    }
    
    //MARK: Methods
    internal func signInButtonTapped() {
		//self.dismissKeyboard()
		
        guard let username = _usernameTextField.text else {
            let alertController = UIAlertController(title: "Oops!", message: "Email or username is missing", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        guard let password = _passwordTextField.text else {
            let alertController = UIAlertController(title: "Oops!", message: "Password is missing", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
	
		
		//handle loading
		_loadingButton.userInteractionEnabled = false
		_loadingButton.loading = true
        
        BDFAuthenticatedUser.currentUser.logInWithUsername(username, password: password, progressBlock: nil, successBlock: { (user: User, accessToke: String, refreshToken: String) in
            DTLog("Success")
            
            //Go to discovery
            let userViewController = UserTabbarController()
            self.containerViewController?.presentViewController(userViewController, completion: nil)
            
            //Save user data
            DTLog(BDFAuthenticatedUser.currentUser.description)
            BDFAuthenticatedUser.currentUser.save()
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            if error?.code == NSURLErrorNotConnectedToInternet {
                let internetAlertController = UIAlertController.internetConnectionAlertController(nil)
                self.presentViewController(internetAlertController, animated: true, completion: {
                    
                })
            }
            else {
                if errorCode == 5 {
                    // Disable animation
                    self._loadingButton.userInteractionEnabled = true
                    self._loadingButton.loading = false
                    
                    // Wrong password
                    let alertController = UIAlertController(title: nil, message: "Invalid username and password.", preferredStyle: UIAlertControllerStyle.Alert)
                    let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(cancelButton)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
	
	internal func signInWithFacebookButtonTapped() {
		self.dismissKeyboard()
	}
	
    internal func forgotPasswordButtonTapped() {
		self.dismissKeyboard()
		let alertController = UIAlertController(title: "No worries!", message: "Let us send you a new password", preferredStyle: UIAlertControllerStyle.Alert)
		let cancelButton = UIAlertAction(title: "Ok!", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
			
		})
		alertController.addAction(cancelButton)
		self.presentViewController(alertController, animated: true, completion: nil)
    }
	
	internal func createNewAccountButtonTapped() {
		
		let signUpViewController = SignUpViewController()
		self.navigationController?.pushViewController(signUpViewController, animated: true)
		
	}
	
	internal func questionButtonTapped() {
		self.dismissKeyboard()
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		
		if textField == _usernameTextField {
			_passwordTextField.becomeFirstResponder()
		} else {
			self.dismissKeyboard()
		}
		return false

	}
	
	func dismissKeyboard() {
		_usernameTextField.resignFirstResponder()
		_passwordTextField.resignFirstResponder()
	}
	
    //MARK: UITextfield delegate
	func textFieldDidUpdate(){
		if  _passwordTextField.text == "" || _usernameTextField.text == "" {
			_loadingButton.enabled = false

		} else {
			_loadingButton.enabled = true
		}
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		//Validating text field
		if textField == _usernameTextField {
			if textField.text == "" {
				_signInNode._errorUsernameLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: .Right)
				
				_signInNode._errorUsernameLabel.hidden = false
				
			} else {
				
				_signInNode._errorUsernameLabel.hidden = true
				
			}
		} else if textField == _passwordTextField {
			
			if textField.text == "" {
				_signInNode._errorPasswordLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: .Right)
			
				_signInNode._errorPasswordLabel.hidden = false
				
			}
			else {
				_signInNode._errorPasswordLabel.hidden = true
				
			}
		}
	}
}



//Sign in node

//Node dimensions
private let kLeftInset : CGFloat = 30
private let kRightInset : CGFloat = 30
private let kTopInset : CGFloat = 64
private let kBottomInset : CGFloat = 0

private let kTextFieldHeight : CGFloat = 14
private let kQuestionButtonSize : CGFloat = 17

private let kSignInButtonHeight : CGFloat = 41

private let kButtonHorizontalInset : CGFloat = 15
private let kButtonVerticalInset : CGFloat = 15

private let kFacebookIconWidth : CGFloat = 17
private let kFacebookIconHeight : CGFloat = 17

class SignInNode: ASDisplayNode {
	
	//private variables
	private let _signInLabel = ASTextNode()
	private let _usernameLabel = ASTextNode()
	private let _passwordLabel = ASTextNode()
	private let _stripe1 = ASDisplayNode()
	private let _stripe2 = ASDisplayNode()
	private let _faceBookIconImage = ASImageNode()
	
	
	//public variables
    private var _usernameTextField = ASDisplayNode()
    private var _passwordTextField = ASDisplayNode()
    private let _forgotPasswordButton = ASHighLightButton()
	private let _createAccountButton = ASButtonNode()
	private let _signInButton = ASHighLightButton()
	private let _signInWithFacebookButton = ASHighLightButton()
	private let _errorUsernameLabel = ASTextNode()
	private let _errorPasswordLabel = ASTextNode()
	
    override init() {
        super.init()
		self.backgroundColor = UIColor.appScrollViewBackgrouncColor()

//		Init UI elements
//		Sign in label
		_signInLabel.attributedString = NSAttributedString.attributedStringFromFont("SIGN IN", font: UIFont.boldAppFont(21), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		_signInLabel.layerBacked = true
		self.addSubnode(_signInLabel)

		//username label
		_usernameLabel.attributedString = NSAttributedString.attributedStringFromFont("EMAIL", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		_usernameLabel.layerBacked = true
		self.addSubnode(_usernameLabel)
		
		//username text field
		self.addSubnode(_usernameTextField)
		
		//error text label
		_errorUsernameLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
		_errorUsernameLabel.layerBacked = true
		_errorUsernameLabel.hidden = true
		self.addSubnode(_errorUsernameLabel)
		
		//password label
		_passwordLabel.attributedString = NSAttributedString.attributedStringFromFont("PASSWORD", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		self.addSubnode(_passwordLabel)
		
		//password text field
		self.addSubnode(_passwordTextField)
		
		//error text label
		_errorPasswordLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
		_errorPasswordLabel.layerBacked = true
		_errorPasswordLabel.hidden = true
		self.addSubnode(_errorPasswordLabel)
		
		//forgot password button
		_forgotPasswordButton.setTitle( "Forgot your password?" , withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appPurpleColor(), forState: ASControlState.Normal)
		_forgotPasswordButton.setTitle( "Forgot your password?" , withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appPurpleColor().colorWithAlphaComponent(0.3), forState: ASControlState.Highlighted)
		self.addSubnode(_forgotPasswordButton)
		
		//create new account button
		_createAccountButton.setTitle( "Create new account" , withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appPurpleColor(), forState: ASControlState.Normal)
		_createAccountButton.setTitle( "Create new account" , withFont: UIFont.appFont(CGFloat.smallFontSize), withColor: UIColor.appPurpleColor().colorWithAlphaComponent(0.3), forState: ASControlState.Highlighted)
		self.addSubnode(_createAccountButton)
		
		//sign in button
		_signInButton.enabled = false
		_signInButton.cornerRadius = kButtonVerticalInset/5
		_signInButton.contentEdgeInsets = UIEdgeInsets(top: kButtonVerticalInset, left: kButtonHorizontalInset, bottom: kButtonVerticalInset, right: kButtonHorizontalInset)
		_signInButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
		_signInButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: ASControlState.Highlighted)
		_signInButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: ASControlState.Disabled)
		self.addSubnode(_signInButton)
		
		//sign in with fb button
		_signInWithFacebookButton.backgroundColor = UIColor.whiteColor()
		_signInWithFacebookButton.cornerRadius = kButtonVerticalInset/5
		_signInWithFacebookButton.contentEdgeInsets = UIEdgeInsets(top: kButtonVerticalInset, left: kButtonHorizontalInset, bottom: kButtonVerticalInset, right: kButtonHorizontalInset)
		_signInWithFacebookButton.setTitle( "Sign in with Facebook" , withFont: UIFont.boldAppFont(CGFloat.normalFontSize), withColor: UIColor.appPurpleColor(), forState: ASControlState.Normal)
		_signInWithFacebookButton.setTitle( "Sign in with Facebook" , withFont: UIFont.boldAppFont(CGFloat.normalFontSize), withColor: UIColor.appPurpleColor().colorWithAlphaComponent(0.3), forState: ASControlState.Highlighted)
		self.addSubnode(_signInWithFacebookButton)
		
		//facebook icon
		_faceBookIconImage.image = UIImage.likeIconLine(size: CGSize(width: kFacebookIconWidth, height: kFacebookIconHeight), color: UIColor.appPurpleColor())
		_signInWithFacebookButton.view.addSubnode(_faceBookIconImage)
		
		//stripes
		_stripe1.backgroundColor = UIColor.appPurpleColor()
		self.addSubnode(_stripe1)
		_stripe2.backgroundColor = UIColor.appPurpleColor()
		self.addSubnode(_stripe2)
		
    }
	
	
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let width = constrainedSize.max.width

		//Stripe size
		_stripe1.preferredFrameSize = CGSize(width: width, height: 0.5)
		_stripe2.preferredFrameSize = CGSize(width: width, height: 0.5)
		
		_usernameTextField.preferredFrameSize = CGSize(width: width, height: kTextFieldHeight)
		_passwordTextField.preferredFrameSize = CGSize(width: width, height: kTextFieldHeight)

		_faceBookIconImage.frame = CGRect(x: width - kLeftInset - kRightInset - kFacebookIconWidth - 20, y: kButtonVerticalInset*2 + 17 - kFacebookIconHeight, width: kFacebookIconWidth, height: kFacebookIconHeight)

		//Horizontal buttons
		let horizontalButtonSpacer = ASLayoutSpec()
		horizontalButtonSpacer.flexGrow = true
		let horizontalButtonStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing:0, justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [_forgotPasswordButton, horizontalButtonSpacer, _createAccountButton])
		horizontalButtonStack.alignSelf = .Stretch
		
		//Username stack
		_usernameLabel.flexGrow = true
		_errorUsernameLabel.flexShrink = true
		let usernameStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [_usernameLabel, _errorUsernameLabel])
		usernameStack.alignSelf = .Stretch
		
		//Password stack
		_passwordLabel.flexGrow = true
		_errorPasswordLabel.flexShrink = true
		let passwordStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [_passwordLabel, _errorPasswordLabel])
		passwordStack.alignSelf = .Stretch
		
		//Stack alignment
		_signInButton.alignSelf = .Stretch
		_signInWithFacebookButton.alignSelf = .Stretch
		_signInLabel.spacingAfter = 0.05*width
		_signInButton.spacingAfter = 0.03*width
		horizontalButtonStack.spacingAfter = 0.07*width
		_stripe1.spacingAfter = 0.03*width
		_stripe2.spacingAfter = 0.05*width
		
		let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [ _signInLabel, usernameStack ,_usernameTextField, _stripe1,  passwordStack, _passwordTextField, _stripe2,  horizontalButtonStack, _signInButton, _signInWithFacebookButton, horizontalButtonSpacer])
		
		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kTopInset, left: kLeftInset, bottom: kBottomInset , right: kRightInset ), child: verticalStack)
	}
	
	override func layout() {
		super.layout()
	}
}


