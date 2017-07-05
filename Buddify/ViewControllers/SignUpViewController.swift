//
//  SignInViewController.swift
//  Buddify
//
//  Created by Vo Duc Tung on 23/03/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//
import UIKit
import AsyncDisplayKit
import RNLoadingButton_Swift
import Models

class SignUpViewController: ASViewController, UITextFieldDelegate, ASCollectionDelegate,ASCollectionDataSource {
	private let _signUpNode = SignUpNode()
	private let _nameTextField = UITextField()
	private let _emailTextField = UITextField()
	private let _passwordTextField = UITextField()
	private let _questionButton = UIButton()
	private let _loadingButton = RNLoadingButton()
	private let _collectionNode: ASCollectionNode
	private var _layoutInspector = MosaicCollectionViewLayoutInspector()

	init() {
		
		let flowLayout = MosaicCollectionViewLayout()
		flowLayout.numberOfColumns = 1
		flowLayout.headerHeight = 0
		flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		flowLayout.interItemSpacing = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		flowLayout.columnSpacing = 0
		_collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		_collectionNode.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		_collectionNode.view.layoutInspector = _layoutInspector
		super.init(node: _collectionNode)
		_collectionNode.delegate = self
		_collectionNode.dataSource = self
		
	}
	
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		self.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
	
        let placeHolderColor = UIColor(white: 0.3, alpha: 0.3)
		
		//Username textfield
		_nameTextField.delegate = self
		_nameTextField.font = UIFont.appFont(CGFloat.normalFontSize)
		_nameTextField.borderStyle = UITextBorderStyle.None
		_nameTextField.textColor = UIColor.appPurpleColor()
		_nameTextField.autocorrectionType = UITextAutocorrectionType.No
        _nameTextField.autocapitalizationType = UITextAutocapitalizationType.Words
		_nameTextField.keyboardType = UIKeyboardType.Default
		_nameTextField.returnKeyType = UIReturnKeyType.Next
		_nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
		_nameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
        _nameTextField.attributedPlaceholder = NSAttributedString.attributedStringFromFont("e.g. John Smith", font: UIFont.appFont(CGFloat.normalFontSize), textColor: placeHolderColor, textAlignment: nil)
		self.view.addSubview(_nameTextField)
		
		//Email textfield
		_emailTextField.delegate = self
		_emailTextField.font = UIFont.appFont(CGFloat.normalFontSize)
		_emailTextField.borderStyle = UITextBorderStyle.None
		_emailTextField.textColor = UIColor.appPurpleColor()
		_emailTextField.autocorrectionType = UITextAutocorrectionType.No
        _emailTextField.autocapitalizationType = UITextAutocapitalizationType.None
		_emailTextField.keyboardType = UIKeyboardType.EmailAddress
		_emailTextField.returnKeyType = UIReturnKeyType.Next
		_emailTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        _emailTextField.attributedPlaceholder = NSAttributedString.attributedStringFromFont("e.g. john@example.com", font: UIFont.appFont(CGFloat.normalFontSize), textColor: placeHolderColor, textAlignment: nil)
		_emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
		self.view.addSubview(_emailTextField)
		
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
		_passwordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidUpdate), forControlEvents: UIControlEvents.EditingChanged)
        _passwordTextField.attributedPlaceholder = NSAttributedString.attributedStringFromFont("at least 6 characters", font: UIFont.appFont(CGFloat.normalFontSize), textColor: placeHolderColor, textAlignment: nil)
		self.view.addSubview(_passwordTextField)
		
		//Question button
		_questionButton.frame = CGRect(x: 0, y: 0, width: kQuestionButtonSize, height: kQuestionButtonSize)
		_questionButton.setImage(UIImage.questionMarkIcon(size: CGSize(width: kQuestionButtonSize, height: kQuestionButtonSize), color: UIColor.appPurpleColor()), forState: .Normal)
		_questionButton.setImage(UIImage.questionMarkIcon(size: CGSize(width: kQuestionButtonSize, height: kQuestionButtonSize), color: UIColor.appPurpleColor().colorWithAlphaComponent(0.3)), forState: .Highlighted)
		_questionButton.userInteractionEnabled = true
		_questionButton.addTarget(self, action: #selector(SignUpViewController.questionButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		_passwordTextField.rightView = _questionButton
		_passwordTextField.rightViewMode = UITextFieldViewMode.Always
		
		//loading button
		_loadingButton.enabled = false
		_loadingButton.loading = false
        _loadingButton.hideImageWhenLoading = true
        _loadingButton.hideTextWhenLoading = true
		_loadingButton.activityIndicatorAlignment = .Center
		_loadingButton.setActivityIndicatorStyle(UIActivityIndicatorViewStyle.White, state: UIControlState.Normal)
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
		_loadingButton.addTarget(self, action: #selector(SignUpViewController.signUpButtonTapped), forControlEvents: .TouchUpInside)
		self.view.addSubview(_loadingButton)
		
	}
	
	override func layoutSublayersOfLayer(layer: CALayer) {
		super.layoutSublayersOfLayer(layer)
		
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		_nameTextField.frame = _signUpNode.usernameTextField.frame
		_emailTextField.frame = _signUpNode._emailTextField.frame
		_passwordTextField.frame = _signUpNode._passwordTextField.frame
		_nameTextField.frame.size.height = 20
		_emailTextField.frame.size.height = 20
		_passwordTextField.frame.size.height = 20
		_questionButton.frame = CGRect(x: _passwordTextField.frame.size.width - kQuestionButtonSize, y: 0, width: _passwordTextField.frame.size.height, height: _passwordTextField.frame.size.height)
		_loadingButton.frame = _signUpNode.signUpButton.frame
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		
		self.navigationItem.hidesBackButton = true
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
		self.navigationController?.navigationBarHidden = false
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.translucent = true
		DTLog(navigationController!.navigationBarHidden)

		//Exit bar button
		let exitButton = UIButton()
		exitButton.frame = CGRect(x: 0, y: 0, width: kExitButtonSize, height: kExitButtonSize)
		exitButton.setImage(UIImage.cancelIcon(size: CGSize(width: kExitButtonSize, height: kExitButtonSize), color: UIColor.appPurpleColor()), forState: UIControlState.Normal)
		exitButton.addTarget(self, action: #selector(SignUpViewController.exitButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		let rightBarButton = UIBarButtonItem()
		rightBarButton.customView = exitButton
		self.navigationItem.rightBarButtonItem = rightBarButton
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(false, animated: true)
        
		//Notifications
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SignUpViewController.keyboardDidChangeFrame(_:)), name: UIKeyboardDidChangeFrameNotification, object: nil)
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
		var userInfo = notification.userInfo!
		
		let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue

		var collectionNodeFrame = _collectionNode.frame
		collectionNodeFrame.size.height = frameEnd.origin.y
		
			//Change share bar frame
			let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntValue
			
			UIView.animateWithDuration(
				userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue,
				delay: 0,
				options: UIViewAnimationOptions(rawValue: UInt(curve)),
				animations: {
					self._collectionNode.frame = collectionNodeFrame
					self.node.setNeedsDisplay()
				},
				completion: {(flag) -> Void in (
					DTLog(self._collectionNode.frame),
					DTLog(self._signUpNode.frame)

					)}
			)
		
	}
	
	//MARK: ASCollectionDataSource + ASCollectionDelegate
	func collectionView(collectionView: ASCollectionView, nodeForItemAtIndexPath indexPath: NSIndexPath) -> ASCellNode {
		return {
			return _signUpNode
			}()
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView!, layout: MosaicCollectionViewLayout!, originalItemSizeAtIndexPath indexPath: NSIndexPath!) -> CGSize {
		return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height + 150)
	}
	
	//MARK: Selector Methods
	internal func signUpButtonTapped() {
		self.dismissKeyboard()

		guard let username = _nameTextField.text else {
			let alertController = UIAlertController(title: "Oops!", message: "Email or username is missing", preferredStyle: UIAlertControllerStyle.Alert)
			let cancelButton = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
				
			})
			alertController.addAction(cancelButton)
			self.presentViewController(alertController, animated: true, completion: nil)
			return
		}
        
        guard let email = _emailTextField.text else {
            let alertController = UIAlertController(title: "Oops!", message: "Email is missing", preferredStyle: UIAlertControllerStyle.Alert)
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
		
		
		
        //Sign up
		if self.isValidForm() {
			//handle loading
			_loadingButton.userInteractionEnabled = false
			_loadingButton.loading = true
            
            BDFAuthenticatedUser.currentUser.signUpWithName(username, email: email, password: password, progressBlock: nil, successBlock: { (user: User, accessToken: String, refreshToken: String) in
                //Success
                let profileEditViewController = ProfileEditViewController()
                self.navigationController?.pushViewController(profileEditViewController, animated: true)
                
                BDFAuthenticatedUser.currentUser.updateInformation(user)
                BDFAuthenticatedUser.currentUser.save()
                
                }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                    //Handle error
                    if error?.code == NSURLErrorNotConnectedToInternet {
                        let internetAlertController = UIAlertController.internetConnectionAlertController(nil)
                        self.presentViewController(internetAlertController, animated: true, completion: {
                            
                        })
                    }
                    else {
                        if errorCode == 1 {
                            // Email taken
                            let alertController = UIAlertController(title: nil, message: "Email already taken. Please choose another one.", preferredStyle: UIAlertControllerStyle.Alert)
                            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                                
                            })
                            
                            alertController.addAction(cancelButton)
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        else {
                            // Other reason
                            let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                                
                            })
                            
                            alertController.addAction(cancelButton)
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                    }
            })
            
		} else {
			let alertController = UIAlertController(title: "Oops!", message: "Invalid fields, please check again.", preferredStyle: UIAlertControllerStyle.Alert)
			let cancelButton = UIAlertAction(title: "Got it!", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
				
			})
			alertController.addAction(cancelButton)
			self.presentViewController(alertController, animated: true, completion: nil)
		}
	}
	
	internal func exitButtonTapped() {
		self.navigationController?.popViewControllerAnimated(true)
	}
	
	internal func questionButtonTapped() {
		self.dismissKeyboard()
	}
	
	func dismissKeyboard() {
		self._nameTextField.resignFirstResponder()
		self._emailTextField.resignFirstResponder()
		self._passwordTextField.resignFirstResponder()

	}
	
	//MARK: Text field validation
	func isValidName(username:String) -> Bool {
		
		let invalidCharString = ".,?!\'[]{}#%^*+=_\\|~<>$£¥•-/:;()€&@\"1234567890"
		let invalidCharSet = NSCharacterSet.init(charactersInString: invalidCharString)
		let range = username.rangeOfCharacterFromSet(invalidCharSet)
		
		if range == nil && username.characters.count != 0 {
			return true

		} else {
			return false
		}
	}
	
	func isValidPassword(password:String) -> Bool {
		if password.characters.count < 6 {
			return false
		} else {
			return true
		}
	}
	
	func isValidEmail(emailStr:String) -> Bool {
		let REGEX: String
		REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
		return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluateWithObject(emailStr)
	}
	
	//Form validation
	func isValidForm() -> Bool {
		if (isValidName(self._nameTextField.text!) && isValidEmail(self._emailTextField.text!) && isValidPassword(self._passwordTextField.text!)) {
			return true
		}
		return false
	}
	
	//MARK: UITextfield delegate
	func textFieldDidUpdate(){

		if self._nameTextField.text == "" || self._emailTextField.text == "" || self._passwordTextField.text == "" {
			_loadingButton.enabled = false
			
		} else {
			_loadingButton.enabled = true
		}
	}
	
	//Display possible errors when editing done
	func textFieldDidEndEditing(textField: UITextField) {
		//Validating text field
		if textField == self._nameTextField {
			if !self.isValidName(textField.text!) {
				if textField.text == "" {
					self._signUpNode.errorNameLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: .Right)
				} else {
					self._signUpNode.errorNameLabel.attributedString = NSAttributedString.attributedStringFromFont("Name should contain only characters", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
				}
				self._signUpNode.errorNameLabel.hidden = false

			} else {
				
				self._signUpNode.errorNameLabel.hidden = true
				
			}
		} else if textField == self._passwordTextField {
			if !self.isValidPassword(textField.text!) {
				
				if textField.text == "" {
					self._signUpNode.errorPasswordLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: .Right)
				} else {
					self._signUpNode.errorPasswordLabel.attributedString = NSAttributedString.attributedStringFromFont("Password should contain at least 6 characters", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
				}
				self._signUpNode.errorPasswordLabel.hidden = false

			}
			else {
				
				self._signUpNode.errorPasswordLabel.hidden = true
				
			}
		} else if textField == self._emailTextField  {
			if !self.isValidEmail(self._emailTextField.text!) {
				
				if textField.text == "" {
					self._signUpNode.errorEmailLabel.attributedString = NSAttributedString.attributedStringFromFont("Missing field!", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: .Right)
				} else {
					self._signUpNode.errorEmailLabel.attributedString = NSAttributedString.attributedStringFromFont("Email is invalid", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
				}
				self._signUpNode.errorEmailLabel.hidden = false
				
			} else {
				
				self._signUpNode.errorEmailLabel.hidden = true

			}
		}
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		if textField == _nameTextField {
			_emailTextField.becomeFirstResponder()
		} else if textField == _emailTextField  {
			_passwordTextField.becomeFirstResponder()
		} else {
			self.dismissKeyboard()
		}
		return false
		
	}
	
}



//Sign up node

//Node dimensions
private let kLeftInset : CGFloat = 30
private let kRightInset : CGFloat = 30
private let kTopInset : CGFloat = 0
private let kBottomInset : CGFloat = 0

private let kTextFieldHeight : CGFloat = 14
private let kQuestionButtonSize : CGFloat = 17
private let kExitButtonSize : CGFloat = 15

private let kSignInButtonHeight : CGFloat = 41

private let kButtonHorizontalInset : CGFloat = 15
private let kButtonVerticalInset : CGFloat = 15



class SignUpNode: ASCellNode, ASTextNodeDelegate {
	
	//private variables
	private let signUpLabel = ASTextNode()
	private let nameLabel = ASTextNode()
	private let emailLabel = ASTextNode()
	private let passwordLabel = ASTextNode()

	private let stripe1 = ASDisplayNode()
	private let stripe2 = ASDisplayNode()
	private let stripe3 = ASDisplayNode()

	//public variables
	let usernameTextField = ASDisplayNode()
	let _passwordTextField = ASDisplayNode()
	let _emailTextField = ASDisplayNode()
	let signUpButton = ASHighLightButton()
	let userTerm = ASTextNode()
	let exitButton = ASHighLightButton()
	let errorNameLabel = ASTextNode()
	let errorEmailLabel = ASTextNode()
	let errorPasswordLabel = ASTextNode()
	let kLinkAttributeName = "NodeLinkAttributeName"
	
	override init() {
		super.init()
		
		//Sign in label
		signUpLabel.attributedString = NSAttributedString.attributedStringFromFont("SIGN UP", font: UIFont.boldAppFont(21), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		signUpLabel.layerBacked = true
		self.addSubnode(signUpLabel)
		
		//username label
		nameLabel.attributedString = NSAttributedString.attributedStringFromFont("NAME", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		nameLabel.layerBacked = true
		self.addSubnode(nameLabel)
		
		//error text label
		errorNameLabel.attributedString = NSAttributedString.attributedStringFromFont("Name should contain only characters", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
		errorNameLabel.layerBacked = true
		errorNameLabel.hidden = true
		self.addSubnode(errorNameLabel)
		
		//username text field
		self.addSubnode(usernameTextField)
		
		//email label
		emailLabel.attributedString = NSAttributedString.attributedStringFromFont("EMAIL", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		emailLabel.layerBacked = true
		self.addSubnode(emailLabel)
		
		//error text label
		errorEmailLabel.attributedString = NSAttributedString.attributedStringFromFont("Email is invalid", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
		errorEmailLabel.layerBacked = true
		errorEmailLabel.hidden = true
		self.addSubnode(errorEmailLabel)
		
		//email text field
		self.addSubnode(_emailTextField)
		
		//password label
		passwordLabel.attributedString = NSAttributedString.attributedStringFromFont("PASSWORD", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: nil)
		self.addSubnode(passwordLabel)
		
		//error text label
		errorPasswordLabel.attributedString = NSAttributedString.attributedStringFromFont("Password should contain at least 6 characters", font: UIFont.appFont(10), textColor: UIColor.redColor(), textAlignment: nil)
		errorPasswordLabel.layerBacked = true
		errorPasswordLabel.hidden = true
		self.addSubnode(errorPasswordLabel)
		
		//password text field
		self.addSubnode(_passwordTextField)
		
		//user term
		userTerm.delegate = self
		userTerm.userInteractionEnabled = true
		userTerm.linkAttributeNames = [kLinkAttributeName]
		let text = "By registering, I agree with the following term of use."
		let string = NSMutableAttributedString.init(string: text)
		string.addAttribute(NSFontAttributeName, value: UIFont.appFont(CGFloat.smallFontSize), range: NSMakeRange(0, text.characters.count))
		string.addAttributes( [ NSForegroundColorAttributeName: UIColor.appPurpleColor()] , range: NSRange(location: 0, length: text.characters.count))
		string.addAttributes( [kLinkAttributeName: NSURL(string: "http://placekitten.com/")!,                           NSForegroundColorAttributeName: UIColor.appPurpleColor(), NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue ] , range: (text as NSString).rangeOfString("term of use."))
		userTerm.attributedString = string
		self.addSubnode(userTerm)

		//sign up button
		signUpButton.enabled = false
		signUpButton.cornerRadius = kButtonVerticalInset/5
		signUpButton.contentEdgeInsets = UIEdgeInsets(top: kButtonVerticalInset, left: kButtonHorizontalInset, bottom: kButtonVerticalInset, right: kButtonHorizontalInset)
		signUpButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
		signUpButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: ASControlState.Highlighted)
		signUpButton.setTitle( "GO" , withFont: UIFont.boldAppFont(18), withColor: UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: ASControlState.Disabled)
//		signUpButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forState: ASControlState.Normal)
//		signUpButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor().colorWithAlphaComponent(0.3)), forState: ASControlState.Highlighted)
//		signUpButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor().colorWithAlphaComponent(0.3)), forState: ASControlState.Disabled)
		self.addSubnode(signUpButton)
		
		//stripes
		stripe1.backgroundColor = UIColor.appPurpleColor()
		self.addSubnode(stripe1)
		stripe2.backgroundColor = UIColor.appPurpleColor()
		self.addSubnode(stripe2)
		stripe3.backgroundColor = UIColor.appPurpleColor()
		self.addSubnode(stripe3)
		
		self.backgroundColor = UIColor.appScrollViewBackgrouncColor()
		
	}
	
	
	
	override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let width = constrainedSize.max.width

		//Stripe size
		stripe1.preferredFrameSize = CGSize(width: width, height: 0.5)
		stripe2.preferredFrameSize = CGSize(width: width, height: 0.5)
		stripe3.preferredFrameSize = CGSize(width: width, height: 0.5)

		_passwordTextField.preferredFrameSize = CGSize(width: width, height: kTextFieldHeight)
		usernameTextField.preferredFrameSize = CGSize(width: width, height: kTextFieldHeight)
		_emailTextField.preferredFrameSize = CGSize(width: width, height: kTextFieldHeight)

		//button spacer
		let buttonSpacer = ASLayoutSpec()
		buttonSpacer.flexGrow = true
		
		nameLabel.flexGrow = true
		errorNameLabel.flexShrink = true
		let nameStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [nameLabel, errorNameLabel])
		nameStack.alignSelf = .Stretch
		
		emailLabel.flexGrow = true
		errorEmailLabel.flexShrink = true
		let emailStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [emailLabel, errorEmailLabel])
		emailStack.alignSelf = .Stretch
		
		passwordLabel.flexGrow = true
		passwordLabel.spacingAfter = 20
		errorPasswordLabel.flexShrink = true
		let passwordStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Horizontal, spacing: 0 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [passwordLabel, errorPasswordLabel])
		passwordStack.alignSelf = .Stretch

		//Stack alignment
		signUpButton.alignSelf = .Stretch
		signUpLabel.spacingAfter = 0.05*width
		signUpButton.spacingAfter = 0.03*width
		stripe1.spacingAfter = 0.03*width
		stripe2.spacingAfter = 0.03*width
		stripe3.spacingAfter = 0.07*width
		userTerm.spacingAfter = 0.07*width
		
		let verticalStack = ASStackLayoutSpec(direction: ASStackLayoutDirection.Vertical, spacing: 10 , justifyContent: ASStackLayoutJustifyContent.Center, alignItems: ASStackLayoutAlignItems.Start, children: [signUpLabel, nameStack ,usernameTextField, stripe1, emailStack, _emailTextField ,stripe2, passwordStack, _passwordTextField, stripe3, userTerm, signUpButton, buttonSpacer])

		return ASInsetLayoutSpec(insets: UIEdgeInsets(top: kTopInset, left: kLeftInset, bottom: kBottomInset , right: kRightInset ), child: verticalStack)
	}

	override func layout() {
		super.layout()
	}
	
	//text node delegate, open URL term of service
	func textNode(textNode: ASTextNode, shouldHighlightLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint) -> Bool {
		return true
	}
	
	func textNode(textNode: ASTextNode, tappedLinkAttribute attribute: String, value: AnyObject, atPoint point: CGPoint, textRange: NSRange) {
		
		UIApplication.sharedApplication().openURL(value as! NSURL)

	}
}


