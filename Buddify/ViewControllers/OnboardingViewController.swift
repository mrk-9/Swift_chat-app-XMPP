//
//  OnboardingViewController.swift
//  OnboardingBuddify
//
//  Created by Thinh Duc on 31/03/16.
//  Copyright © 2016 Thinh Duc. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import Models

private let originCardImageViewX: CGFloat = (CGFloat.screenWidth - originCardImageViewWidth) / 2
private let originCardImageViewY: CGFloat = 40
private let originCardImageViewWidth: CGFloat = 180
private let originCardImageViewHeight: CGFloat = 240

private let logoImageViewX: CGFloat = (CGFloat.screenWidth - logoImageViewWidth) / 2
private let logoImageViewY: CGFloat = (bigLabelY - (originCardImageViewHeight + originCardImageViewY)) / 2 + originCardImageViewHeight + originCardImageViewY - logoImageViewHeight / 2
private let logoImageViewWidth: CGFloat = 70
private let logoImageViewHeight: CGFloat = 100


private let bigLabelX: CGFloat = 0
private let bigLabelY: CGFloat = smallLabelY - 8 - bigLabelHeight
private let bigLabelWidth: CGFloat = CGFloat.screenWidth
private let bigLabelHeight: CGFloat = 30

private let smallLabelX: CGFloat = 0
private let smallLabelY: CGFloat = CGFloat.screenHeight - 36 - smallLabelHeight
private let smallLabelWidth: CGFloat = CGFloat.screenWidth
private let smallLabelHeight: CGFloat = 20

private let messageImageViewX: CGFloat = 80
private let messageImageViewY: CGFloat = 80
private let messageImageViewWidth: CGFloat = 60
private let messageImageViewHeight: CGFloat = 50

private let manImageViewX: CGFloat = (CGFloat.screenWidth - manImageViewWidth) / 2 - 60
private let manImageViewY: CGFloat = logoImageViewY + logoImageViewHeight - manImageViewHeight
private let manImageViewWidth: CGFloat = 120
private let manImageViewHeight: CGFloat = 120

private let womanImageViewX: CGFloat = (CGFloat.screenWidth - manImageViewWidth) / 2 + 40
private let womanImageViewY: CGFloat = logoImageViewY + logoImageViewHeight - womanImageViewHeight
private let womanImageViewWidth: CGFloat = 150
private let womanImageViewHeight: CGFloat = 150

private let planeSetImageViewX: CGFloat = 0
private let planeSetImageViewY: CGFloat = womanImageViewY - planeSetImageViewHeight
private let planeSetImageViewWidth: CGFloat = CGFloat.screenWidth
private let planeSetImageViewHeight: CGFloat = CGFloat.screenWidth / 1.297

private let firstPostImageViewX: CGFloat = 8
private let firstPostImageViewY: CGFloat = 28
private let firstPostImageViewWidth: CGFloat = (CGFloat.screenWidth - 8 * 3) / 2
private let firstPostImageViewHeight: CGFloat = 1.5 * firstPostImageViewWidth

private let secondPostImageViewX: CGFloat = firstPostImageViewX + firstPostImageViewWidth + 8
private let secondPostImageViewY: CGFloat = firstPostImageViewY
private let secondPostImageViewWidth: CGFloat = firstPostImageViewWidth
private let secondPostImageViewHeight: CGFloat = 1.8 * secondPostImageViewWidth

private let thirdPostImageViewX: CGFloat = firstPostImageViewX
private let thirdPostImageViewY: CGFloat = firstPostImageViewY + firstPostImageViewHeight + 8
private let thirdPostImageViewWidth: CGFloat = firstPostImageViewWidth
private let thirdPostImageViewHeight: CGFloat = 0

private let fourthPostImageViewX: CGFloat = secondPostImageViewX
private let fourthPostImageViewY: CGFloat = secondPostImageViewY + secondPostImageViewHeight + 8
private let fourthPostImageViewWidth: CGFloat = firstPostImageViewX + firstPostImageViewWidth + 8
private let fourthPostImageViewHeight: CGFloat = 0

private let signInButtonX: CGFloat = 8
private let signInButtonY: CGFloat = signUpButtonY - signUpButtonHeight - 8
private let signInButtonWidth: CGFloat = CGFloat.screenWidth - 2 * 8
private let signInButtonHeight: CGFloat = 0.16 * signInButtonWidth

private let signUpButtonX: CGFloat = signInButtonX
private let signUpButtonY: CGFloat = facebookButtonY - facebookButtonHeight - 8
private let signUpButtonWidth: CGFloat = signInButtonWidth
private let signUpButtonHeight: CGFloat = signInButtonHeight

private let facebookButtonX: CGFloat = signInButtonX
private let facebookButtonY: CGFloat = CGFloat.screenHeight - facebookButtonHeight - 40
private let facebookButtonWidth: CGFloat = signInButtonWidth
private let facebookButtonHeight: CGFloat = signInButtonHeight

private let standingManImageViewX: CGFloat = CGFloat.screenWidth / 2 - 100
private let standingManImageViewY: CGFloat = signInButtonY - 16 - standingManImageViewHeight
private let standingManImageViewWidth: CGFloat = 123
private let standingManImageViewHeight: CGFloat = 242

private let standingWomanImageViewX: CGFloat = CGFloat.screenWidth / 2 - 24
private let standingWomanImageViewY: CGFloat = signInButtonY - 16 - standingWomanImageViewHeight
private let standingWomanImageViewWidth: CGFloat = 123
private let standingWomanImageViewHeight: CGFloat = 180

private let getStartedLabelX: CGFloat = 16
private let getStartedLabelY: CGFloat = 28
private let getStartedLabelWidth: CGFloat = CGFloat.screenWidth - 2 * getStartedLabelX
private let getStartedLabelHeight: CGFloat = 0

class OnboardingViewController: UIViewController {
    var shouldShowIntroduction = true
    var firstLoad = true
    
    private let numberOfOnboardingPages = 4
    
    private var scrollView: UIScrollView!
    private var pageControl: OnboardingPageControl!
    
    private var logoImageView: UIImageView!
    private var bigLabel: UILabel!
    private var smallLabel: UILabel!
    
    // View 1
    private var firstCardImageView: UIImageView!
    private var secondCardImageView: UIImageView!
    private var thirdCardImageView: UIImageView!
    
    // View 2
    private var messageImageView: UIImageView?
    private var manImageView: UIImageView!
    private var womanImageView: UIImageView!
    private var planeSetImageView: UIImageView!
    
    // View 3
    private var firstPostImageView: UIImageView?
    private var secondPostImageView: UIImageView?
    private var thirdPostImageView: UIImageView?
    private var fourthPostImageView: UIImageView?
    
    // View 4
    private var signInButton: HighLightButton!
    private var signUpButton: HighLightButton!
    private var facebookButton: HighLightButton!
    private var standingManImageView: UIImageView!
    private var standingWomanImageView: UIImageView!
    private var getStartedLabel: UILabel!
    
    private var pageControlProgess: CGFloat = 0.0
    
    private let firstCardAngle = CGFloat(-M_PI_2 / 3)
    private let secondCardAngle = CGFloat(M_PI_2 / 4)
    private let thirdCardAngle = CGFloat(-M_PI_2 / 8)
    
    private let firstCardScale: CGFloat = 0.9
    private let secondCardScale: CGFloat = 0.7
    private let thirdCardScale: CGFloat = 0.5
    
    private let firstCardFinalCenterX: CGFloat = 60
    private let firstCardFindalCenterY: CGFloat = 190
    private let secondCardFinalCenterX: CGFloat = CGFloat.screenWidth - 40
    private let secondCardFinalCenterY: CGFloat = 150
    private let thirdCardFinalCenterX: CGFloat = CGFloat.screenWidth / 2
    private let thirdCardFinalCenterY: CGFloat = 70
    
    private var firstStageFirstLaunch: Bool = true
    private var secondStageFirstLaunch: Bool = true
    private var thirdStageFirstLaunch: Bool = true
    private var fourthStageFirstLaunch: Bool = true
    
    private var firstPostImageViewAnimationStillInprogress: Bool = false
    private var secondPostImageViewAnimationStillInprogress: Bool = false
    private var thirdPostImageViewAnimationStillInprogress: Bool = false
    private var fourthPostImageViewAnimationStillInprogress: Bool = false
    
    private let onRemovingMessageImageViewKey = "rotateOnRemoving"
    
    private let onRemovingFirstPostImageViewKey = "removingFirstPost"
    private let onRemovingSecondPostImageViewKey = "removingSecondPost"
    private let onRemovingThirdPostImageViewKey = "removingThirdPost"
    private let onRemovingFourthPostImageViewKey = "removingFourthPost"
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        pageControl = OnboardingPageControl(attatchedToView: view, numberOfPages: numberOfOnboardingPages)
        scrollView = UIScrollView(frame: CGRect(origin: CGPointZero, size: CGSize.screenSize))
        scrollView.contentSize = CGSize(width: CGFloat.screenWidth * CGFloat(numberOfOnboardingPages), height: CGFloat.screenHeight)
        scrollView.pagingEnabled = true
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        scrollView.userInteractionEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        self.scrollView.scrollEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clearColor()
        self.view.insertSubview(scrollView, belowSubview: self.view)
        
        setupHelper()
        self.animator = UIDynamicAnimator(referenceView: view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if firstLoad {
            if !shouldShowIntroduction {
                scrollView.setContentOffset(CGPoint(x: scrollView.frame.size.width*3, y: 0), animated: false)
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: setup
    private func setupHelper() {
        // VIEW 1
        firstCardImageView = UIImageView(frame: CGRectMake(originCardImageViewX, originCardImageViewY, originCardImageViewWidth, originCardImageViewHeight))
        secondCardImageView = UIImageView(frame: CGRectMake(originCardImageViewX, originCardImageViewY, originCardImageViewWidth, originCardImageViewHeight))
        thirdCardImageView = UIImageView(frame: CGRectMake(originCardImageViewX, originCardImageViewY, originCardImageViewWidth, originCardImageViewHeight))
        firstCardImageView.image = UIImage.imageWithImage(UIImage(named: "onboardingCard1")!, scaledToSize: CGSize(width: originCardImageViewWidth, height: originCardImageViewHeight))
        secondCardImageView.image = UIImage.imageWithImage(UIImage(named: "onboardingCard2")!, scaledToSize: CGSize(width: originCardImageViewWidth, height: originCardImageViewHeight))
        thirdCardImageView.image = UIImage.imageWithImage(UIImage(named: "onboardingCard1")!, scaledToSize: CGSize(width: originCardImageViewWidth, height: originCardImageViewHeight))
        
        firstCardImageView.layer.shouldRasterize = true
        secondCardImageView.layer.shouldRasterize = true
        thirdCardImageView.layer.shouldRasterize = true
        
        firstCardImageView.alpha = 0
        secondCardImageView.alpha = 0
        thirdCardImageView.alpha = 0
        // VIEW 2
        manImageView = UIImageView(frame: CGRectMake(manImageViewX, manImageViewY, manImageViewWidth, manImageViewHeight))
        womanImageView = UIImageView(frame: CGRectMake(womanImageViewX, womanImageViewY, womanImageViewWidth, womanImageViewHeight))
        planeSetImageView = UIImageView(frame: CGRectMake(planeSetImageViewX, planeSetImageViewY, planeSetImageViewWidth, planeSetImageViewHeight))
        planeSetImageView.image = UIImage.imageWithImage(UIImage(named: "PlaneSet")!, scaledToSize: CGSize(width: planeSetImageViewWidth, height: planeSetImageViewHeight))
        manImageView.image = UIImage(named: "Cicle_man")
        womanImageView.image = UIImage(named: "Circle_woman")
        manImageView.alpha = 0
        womanImageView.alpha = 0
        planeSetImageView.alpha = 0
        // VIEW 4
        signInButton = HighLightButton(frame: CGRectMake(signInButtonX, signInButtonY, signInButtonWidth, signInButtonHeight))
        signUpButton = HighLightButton(frame: CGRectMake(signUpButtonX, signUpButtonY, signUpButtonWidth, signUpButtonHeight))
        facebookButton = HighLightButton(frame: CGRectMake(facebookButtonX, facebookButtonY, facebookButtonWidth, facebookButtonHeight))
        getStartedLabel = UILabel(frame: CGRectMake(getStartedLabelX, getStartedLabelY, getStartedLabelWidth, getStartedLabelHeight))
        standingManImageView = UIImageView(frame: CGRectMake(standingManImageViewX, standingManImageViewY, standingManImageViewWidth, standingManImageViewHeight))
        standingWomanImageView = UIImageView(frame: CGRectMake(standingWomanImageViewX, standingWomanImageViewY, standingWomanImageViewWidth, standingWomanImageViewHeight))
        
        signInButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
        signUpButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
        
        facebookButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
        
        signInButton.setBackgroundImage(UIImage.image(UIColor.appPurpleColor()), forState: UIControlState.Normal)
        signInButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Sign In", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor(), textAlignment: .Center), forState: UIControlState.Normal)
        signInButton.layer.masksToBounds = true
        signInButton.layer.cornerRadius = 2
        
        signUpButton.setBackgroundImage(UIImage.image(UIColor.whiteColor()), forState: UIControlState.Normal)
        signUpButton.layer.borderColor = UIColor.appPurpleColor().CGColor
        signUpButton.layer.borderWidth = 1
        signUpButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Sign Up", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.appPurpleColor(), textAlignment: .Center), forState: UIControlState.Normal)
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.cornerRadius = 2
        
        facebookButton.setBackgroundImage(UIImage.image(UIColor.facebookColor()), forState: UIControlState.Normal)
        facebookButton.setAttributedTitle(NSAttributedString.attributedStringFromFont("Sign in with facebook", font: UIFont.boldAppFont(CGFloat.normalFontSize), textColor: UIColor.whiteColor(), textAlignment: .Center), forState: UIControlState.Normal)
        facebookButton.layer.masksToBounds = true
        facebookButton.layer.cornerRadius = 2

        standingManImageView.image = UIImage(named: "StandingMan")
        standingWomanImageView.image = UIImage(named: "StandingWoman")
        
        signInButton.addTarget(self, action: #selector(self.dynamicType.signInButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        signUpButton.addTarget(self, action: #selector(self.dynamicType.signUpButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        facebookButton.addTarget(self, action: #selector(self.dynamicType.facebookButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        
        signInButton.alpha = 0.0
        signUpButton.alpha = 0.0
        facebookButton.alpha = 0.0
        standingWomanImageView.alpha = 0.0
        standingManImageView.alpha = 0.0
        getStartedLabel.alpha = 0.0
        // Logo
        logoImageView = UIImageView(frame: CGRectMake(logoImageViewX, logoImageViewY, logoImageViewWidth, logoImageViewHeight))
        logoImageView.transform = CGAffineTransformMakeTranslation(0, 300)
        logoImageView.alpha = 0
        logoImageView.image = UIImage(named: "Applogo")
        //logoImageView.backgroundColor = UIColor.redColor()
        bigLabel = UILabel(frame: CGRectMake(bigLabelX, bigLabelY, bigLabelWidth, bigLabelHeight))
        smallLabel = UILabel(frame: CGRectMake(smallLabelX, smallLabelY, smallLabelWidth, smallLabelHeight))
        // Label
        bigLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 28)
        bigLabel.adjustsFontSizeToFitWidth = true
        bigLabel.alpha = 0
        bigLabel.textAlignment = .Center
        bigLabel.textColor = UIColor.appPurpleColor()
        
        smallLabel.font = UIFont(name: "AvenirNextCondensed-Medium", size: 14)
        smallLabel.adjustsFontSizeToFitWidth = true
        smallLabel.alpha = 0
        smallLabel.textAlignment = .Center
        smallLabel.textColor = UIColor.appPurpleColor()
        
        self.view.addSubview(bigLabel)
        self.view.addSubview(smallLabel)
        self.view.addSubview(womanImageView)
        self.view.addSubview(manImageView)
        self.view.addSubview(planeSetImageView)
        self.view.addSubview(signInButton)
        self.view.addSubview(signUpButton)
        self.view.addSubview(facebookButton)
        self.view.addSubview(standingManImageView)
        self.view.addSubview(standingWomanImageView)
        self.view.addSubview(logoImageView)
        self.view.addSubview(thirdCardImageView)
        self.view.addSubview(secondCardImageView)
        self.view.addSubview(firstCardImageView)
    }
    
    func signInButtonTapped() {
        let viewController = SignInViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func signUpButtonTapped() {
        let viewController = SignUpViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func facebookButtonTapped() {
        FacebookUtility.getFacebookInfo(self) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
            if error != nil {
                DTLog("No error.")
            }
            else {
                if result.isCancelled {
                    DTLog("Is canceled.")
                }
                else {
                    DTLog("Everything is fine.")
                    // Login with facebook
                    BDFAuthenticatedUser.currentUser.loginWithFacebook(result.token.tokenString, progressBlock: nil, successBlock: { (user: BDFAuthenticatedUser, requestCredential: Bool) in
                        // Login into the app
                        let userViewController = UserTabbarController()
                        self.containerViewController?.presentViewController(userViewController, completion: { 
                            
                        })
                        }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                            // Show error
                            if error?.code == NSURLErrorNotConnectedToInternet {
                                let internetAlertController = UIAlertController.internetConnectionAlertController(nil)
                                self.presentViewController(internetAlertController, animated: true, completion: {
                                    
                                })
                            }
                            else {
                                // Other reason
                                let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                                let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                                    
                                })
                                
                                alertController.addAction(cancelButton)
                                self.presentViewController(alertController, animated: true, completion: nil)
                            }
                    })
                }
            }
        }
    }
    
    // Transform 3 button
    private func flushButtons() {
        UIView.animateWithDuration(0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.signInButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
            self.signInButton.alpha = 0.0
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.signUpButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
            self.signUpButton.alpha = 0.0
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.facebookButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)
            self.facebookButton.alpha = 0.0
            }, completion: nil)
    }
    
    private func revealButtons() {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.signInButton.transform = CGAffineTransformIdentity
            self.signInButton.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.signUpButton.transform = CGAffineTransformIdentity
            self.signUpButton.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.30, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseIn, animations: {
            self.facebookButton.transform = CGAffineTransformIdentity
            self.facebookButton.alpha = 1.0
            }, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstLoad {
            firstLoad = false
            didMoveToFirstStage(isFirstTime: true)
        }
    }
    
    private func animateLogoImageView() {
        let randomNumber = Int(random()%10)
        UIView.animateWithDuration(0.4, animations: {
            self.logoImageView.center.y -= randomNumber >= 5 ? 30 : 40
        })
        
        animator.removeAllBehaviors()
        gravity = UIGravityBehavior(items: [logoImageView])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [logoImageView])
        // add a boundary that has the same frame as the barrier
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: CGRectMake(0, logoImageViewY + logoImageViewHeight, CGFloat.screenWidth, 5)))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [logoImageView])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)
    }
    
    private func revealCardImageViews() {
        
        let firstCardRotateTransform = CGAffineTransformRotate(CGAffineTransformIdentity, firstCardAngle)
        let secondCardRotateTransform = CGAffineTransformRotate(CGAffineTransformIdentity, secondCardAngle)
        let thirdCardRotateTransform = CGAffineTransformRotate(CGAffineTransformIdentity, thirdCardAngle)

        let firstCardScaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, firstCardScale, firstCardScale)
        let secondCardScaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, secondCardScale, secondCardScale)
        let thirdCardScaleTransform = CGAffineTransformScale(CGAffineTransformIdentity, thirdCardScale, thirdCardScale)
        
        UIView.animateKeyframesWithDuration(2.5, delay: 0.3, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.6, animations: {
                self.firstCardImageView.alpha = 1.0
                self.firstCardImageView.center.x = self.firstCardFinalCenterX
                self.firstCardImageView.center.y = self.firstCardFindalCenterY
                self.firstCardImageView.transform = CGAffineTransformConcat(firstCardScaleTransform, firstCardRotateTransform)
                
            })
            UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.8, animations: {
                self.secondCardImageView.alpha = 1.0
                self.secondCardImageView.center.x = self.secondCardFinalCenterX
                self.secondCardImageView.center.y = self.secondCardFinalCenterY
                self.secondCardImageView.transform = CGAffineTransformConcat(secondCardScaleTransform, secondCardRotateTransform)
            })
            UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2, animations: {
                self.thirdCardImageView.alpha = 1.0
                self.thirdCardImageView.center.x = self.thirdCardFinalCenterX
                self.thirdCardImageView.center.y = self.thirdCardFinalCenterY
                self.thirdCardImageView.transform = CGAffineTransformConcat(thirdCardScaleTransform, thirdCardRotateTransform)
            })
            }, completion: nil)
   
    }
    
    func flushCardImageViews(withProgress progress: CGFloat) {
        
        let firstCardRotationTransform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(-M_PI_2/8) * progress + firstCardAngle )
        let secondCardRotationTransform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(M_PI_2/8) * progress + secondCardAngle )
        let thirdCardRotationTransform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(-M_PI_2/10) * progress + thirdCardAngle)
        firstCardImageView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, firstCardScale, firstCardScale), firstCardRotationTransform)
        secondCardImageView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, secondCardScale, secondCardScale), secondCardRotationTransform)
        thirdCardImageView.transform = CGAffineTransformConcat(CGAffineTransformScale(CGAffineTransformIdentity, thirdCardScale, thirdCardScale), thirdCardRotationTransform)
        firstCardImageView.center.x = firstCardFinalCenterX - progress * 40
        firstCardImageView.center.y = firstCardFindalCenterY - progress * 20
        secondCardImageView.center.x = secondCardFinalCenterX + progress  * 50
        secondCardImageView.center.y = secondCardFinalCenterY + progress  * 10
        thirdCardImageView.center.y = 70 - progress * 30
 
        let alpha = 1 - progress
        firstCardImageView.alpha = alpha
        secondCardImageView.alpha = alpha
        thirdCardImageView.alpha = alpha
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func didMoveToFirstStage(isFirstTime first: Bool) {
        if first {
            UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseOut, animations: {
                self.logoImageView.transform = CGAffineTransformIdentity
                self.logoImageView.alpha = 1.0
                }, completion: { _ in
                    self.smallLabel.text = "Discover new friends around the world"
                    self.bigLabel.text = "Welcome To Buddify"
                    UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseIn, animations: {
                        self.smallLabel.alpha = 1
                        self.bigLabel.alpha = 1
                        }, completion: nil)
            })
            
            delay(0.5, block: { 
                self.revealCardImageViews()
            })
            
            delay(2.0, block: {
                self.pageControl.expandPageControlItems({
                    self.scrollView.scrollEnabled = true
                })
            })
        }
        firstStageFirstLaunch = false
        secondStageFirstLaunch = true
        thirdStageFirstLaunch = true
        fourthStageFirstLaunch = true
    }
    
    private func didMoveToSecondStage(isFirstTime first: Bool) {
        animateLogoImageView()
        if first {
            // Setup messageImageView
            if messageImageView == nil {
                messageImageView = UIImageView(frame: CGRectMake(messageImageViewX, messageImageViewY, messageImageViewWidth, messageImageViewHeight))
                messageImageView!.layer.anchorPoint.y = 1.0
                messageImageView!.alpha = 0.0
                messageImageView!.layer.shouldRasterize = true
                messageImageView?.image = UIImage.onboardingMessageIcon(size: CGSize(width: messageImageViewWidth, height: messageImageViewHeight), color: UIColor.darkGrayColor())
                let label = UILabel(frame: CGRectMake(0, 8, messageImageView!.bounds.size.width, 20))
                label.textColor = UIColor.whiteColor()
                label.text = "Moi!"
                label.textAlignment = .Center
                
                messageImageView?.addSubview(label)
                view.addSubview(messageImageView!)
            }
            // Animate the messageImageView
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, CGFloat(-M_PI_4), -1.0, 0.0, 0.0)
            transform.m34 =  -1.0/250.0
            messageImageView?.layer.transform = transform
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 1.0
            opacityAnimation.toValue = 1.0
            opacityAnimation.duration = 0.5
            opacityAnimation.fillMode = kCAFillModeForwards
            opacityAnimation.removedOnCompletion = false
            
            messageImageView?.layer.addAnimation(opacityAnimation, forKey: nil)
            UIView.animateWithDuration(0.3, animations: {
                self.messageImageView?.alpha = 1.0
            })
            UIView.animateWithDuration(1.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5.0, options: .CurveEaseIn, animations: {
                self.messageImageView?.layer.transform = CATransform3DIdentity
                
                }, completion: nil)
        }
        firstStageFirstLaunch = false
        secondStageFirstLaunch = false
        thirdStageFirstLaunch = true
        fourthStageFirstLaunch = true
    }
    
    private func didMoveToThirdStage(isFirstTime first: Bool) {
        
        if firstPostImageView?.layer.animationForKey(onRemovingFirstPostImageViewKey) != nil {
            firstPostImageView?.layer.removeAnimationForKey(onRemovingFirstPostImageViewKey)
        }
        
        if secondPostImageView?.layer.animationForKey(onRemovingSecondPostImageViewKey) != nil {
            secondPostImageView?.layer.removeAnimationForKey(onRemovingSecondPostImageViewKey)
        }
        
        if (firstPostImageView == nil) {
            firstPostImageView = UIImageView(frame: CGRectMake(firstPostImageViewX, firstPostImageViewY, firstPostImageViewWidth, firstPostImageViewHeight))
            
        }
        if (secondPostImageView == nil) {
            secondPostImageView = UIImageView(frame: CGRectMake(secondPostImageViewX, secondPostImageViewY, secondPostImageViewWidth, secondPostImageViewHeight))
        }
        if first {
            self.view.addSubview(firstPostImageView!)
            self.view.addSubview(secondPostImageView!)
            initializePostImageView(firstPostImageView, imageName: "FirstPost", offSetY: 100)
            initializePostImageView(secondPostImageView, imageName: "SecondPost", offSetY: 120)
            UIView.animateKeyframesWithDuration(1.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.3, animations: {
                    self.firstPostImageView!.transform = CGAffineTransformIdentity
                    self.firstPostImageView!.alpha = 1.0
                })
                UIView.addKeyframeWithRelativeStartTime(0.1, relativeDuration: 0.35, animations: {
                    self.secondPostImageView!.transform = CGAffineTransformIdentity
                    self.secondPostImageView!.alpha = 1.0
                })
                }, completion: nil)
        }
        firstStageFirstLaunch = false
        secondStageFirstLaunch = true
        thirdStageFirstLaunch = false
        fourthStageFirstLaunch = true
    }
    
    private func didMoveToFourthStage(isFirstTime first: Bool) {
        if first {
            revealButtons()
        }
        firstStageFirstLaunch = false
        secondStageFirstLaunch = true
        thirdStageFirstLaunch = true
        fourthStageFirstLaunch = false
    }
    // Initialize postImageView helper method
    private func initializePostImageView(postImageView: UIImageView!, imageName: String, offSetY: CGFloat) {
        postImageView?.alpha = 0
        postImageView?.image = UIImage.imageWithImage(UIImage(named: imageName)!, scaledToSize: CGSize(width: postImageView.frame.size.width, height: postImageView.frame.size.width))
        postImageView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, offSetY)
    }
    // Remove postImageView helper method
    private func removePostImageView(postImageView: UIImageView, delay: NSTimeInterval, animationKey: String, completionHandler: ((Bool) -> Void)?) {
        if postImageView.layer.animationForKey(animationKey) == nil {
            var transform = CATransform3DIdentity
            transform = CATransform3DTranslate(transform, 0.0, -400, 0.0)
            let animation = CABasicAnimation(keyPath: "transform")
            animation.delegate = self
            animation.beginTime = CACurrentMediaTime() + delay
            animation.fromValue = NSValue(CATransform3D: postImageView.layer.transform)
            animation.toValue = NSValue(CATransform3D: transform)
            animation.duration = 0.2
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            postImageView.layer.addAnimation(animation, forKey: animationKey)
        }
    }
    // Update text labels
    private func updateViewsByProgress(progress: CGFloat) {
        if progress >= 0 && progress <= 0.25 {
            updateLabelInRange(0, upper: 0.25, progress: progress, bigLabelText1: "Welcome To Buddify", bigLabelText2: "Send messages", smallLabelText1: "Discover new friends around the world", smallLabelText2: "and get to know each other")
            
        } else if progress > 0.25 && progress <= 0.5 {
            updateLabelInRange(0.25, upper: 0.5, progress: progress, bigLabelText1: "Send messages", bigLabelText2: "Share stories", smallLabelText1: "and get to know each other", smallLabelText2: "and keep in touch with your friends")
            
        } else if progress > 0.5 && progress <= 0.75{
            updateLabelInRange(0.5, upper: 0.75, progress: progress, bigLabelText1: "Share stories", bigLabelText2: "", smallLabelText1: "and keep in touch with your friends", smallLabelText2: "")
        } else {
            updateLabelInRange(0.75, upper: 1.0, progress: progress, bigLabelText1: "", bigLabelText2: "", smallLabelText1: "", smallLabelText2: "")
        }
    }
    
    private func updateLabelInRange(lower: CGFloat, upper: CGFloat, progress: CGFloat, bigLabelText1: String, bigLabelText2: String, smallLabelText1: String, smallLabelText2: String) {
        let firstStage = CGFloat((upper - lower) / 2.0) + lower - 0.025
        let secondStage = CGFloat((upper - lower) / 2.0) + lower + 0.025
        var alpha: CGFloat = 0;
        if progress <= firstStage {
            alpha = min((firstStage - progress)/(firstStage - lower), 1.0)
            bigLabel.text = bigLabelText1
            smallLabel.text = smallLabelText1
        } else if progress >= secondStage {
            alpha = max((progress - secondStage)/(upper - secondStage), 0.0)
            bigLabel.text = bigLabelText2
            smallLabel.text = smallLabelText2
        }
        bigLabel.alpha = alpha
        smallLabel.alpha = alpha
    }
    
    
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let contentOffsetX = scrollView.contentOffset.x
        let progress = min(contentOffsetX / (CGFloat(self.numberOfOnboardingPages) * CGFloat.screenWidth), 1.0)
        // Update page control
        pageControl.updateActivePageControlItem(scrollView)
        // Update text-Labels text
        updateViewsByProgress(progress)
        // Remove the card images view on the first page
        if contentOffsetX >= 0 && contentOffsetX <= CGFloat.screenWidth {
            let flushingCardProgress: CGFloat = min(scrollView.contentOffset.x / (CGFloat.screenWidth / 2), CGFloat(1.0))
            self.flushCardImageViews(withProgress: flushingCardProgress)
        }
        // Remove the messageImageView
        if (contentOffsetX <= (CGFloat.screenWidth / 2 + 10.0)) || (contentOffsetX >= (CGFloat.screenWidth * 3 / 2 - 10.0)) {
            if self.messageImageView != nil {
                // Remove the messageImageView
                var transform = CATransform3DIdentity
                transform = CATransform3DRotate(transform, CGFloat(M_PI_2), -1, 0.0, 0.0)
                transform.m34 = -1 / 250
                
                if (self.messageImageView!.layer.animationForKey("rotateOnRemoving") == nil) {
                    let animation = CABasicAnimation(keyPath: "transform")
                    animation.fromValue = NSValue(CATransform3D: messageImageView!.layer.transform)
                    animation.toValue = NSValue(CATransform3D: transform)
                    animation.duration = 0.2
                    animation.repeatCount = 0.0
                    animation.fillMode = kCAFillModeForwards
                    animation.removedOnCompletion = false
                    animation.delegate = self
                    
                    let opacityAnimation = CABasicAnimation(keyPath: "opacity")
                    opacityAnimation.fromValue = 1.0
                    opacityAnimation.toValue = 0.0
                    opacityAnimation.duration = 0.2
                    opacityAnimation.fillMode = kCAFillModeForwards
                    opacityAnimation.removedOnCompletion = false
                    opacityAnimation.delegate = self
                    
                    self.messageImageView!.layer.addAnimation(animation, forKey: onRemovingMessageImageViewKey)
                    self.messageImageView!.layer.addAnimation(opacityAnimation, forKey: "remove")
                }
            }
        
        }
        // Present the second view (manImageView, womanImageView, planeImageView
        if (progress >= 0.15 && progress <= 0.25) {
            let presentingProgress: CGFloat = min((progress - 0.15)/(0.25 - 0.15), 1.0)
            let alpha: CGFloat = presentingProgress
            updateSecondViewAlpha(alpha)
        } else if(progress > 0.25 && progress <= 0.40) {
            let presentingProgress: CGFloat = max((progress - 0.25)/(0.40 - 0.25), 0.0)
            let alpha: CGFloat = 1 - presentingProgress
            updateSecondViewAlpha(alpha)
        } else {
            updateSecondViewAlpha(0)
        }
        
        // Remove the postImageView
        if (progress >= 0.6 || progress <= 0.4) {
            if (firstPostImageView != nil) {
                removePostImageView(self.firstPostImageView!, delay: 0.0, animationKey: onRemovingFirstPostImageViewKey, completionHandler: nil)
            }
            
            if (secondPostImageView != nil) {
                removePostImageView(self.secondPostImageView!, delay: 0.0, animationKey: onRemovingSecondPostImageViewKey, completionHandler: nil)
                
            }
            
            if (thirdPostImageView != nil) {
                
            }
            
            if (fourthPostImageView != nil) {
                
            }
        }
        // Remove, reveal buttons and imageViews
        if (progress <= 0.60 ) {
            if !fourthStageFirstLaunch {
                flushButtons()
                UIView.animateWithDuration(0.6, animations: {
                    self.standingManImageView.alpha = 0.0
                    self.standingWomanImageView.alpha = 0.0
                    }, completion: { _ in
                        UIView.animateWithDuration(0.5, animations: {
                            self.logoImageView.transform = CGAffineTransformIdentity
                            self.logoImageView.alpha = 1.0
                            }, completion: nil)
                })
                
            }
        } else {
            if fourthStageFirstLaunch {
                // Translate logo and 
                
                UIView.animateWithDuration(0.5, animations: {
                    let translationTransform = CGAffineTransformMakeTranslation(0.0, -200)
                    self.logoImageView.transform = translationTransform
                    self.logoImageView.alpha = 0.0
                    }, completion: { _ in
                        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                            self.standingManImageView.alpha = 1.0
                            self.standingWomanImageView.alpha = 1.0
                            }, completion: nil)
                })
            }
        }
    }
    // Update imageViews' alpha on the second view
    private func updateSecondViewAlpha(alpha: CGFloat) {
        self.manImageView.alpha = alpha
        self.womanImageView.alpha = alpha
        self.planeSetImageView.alpha = alpha
    }
    
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let stage = Int(scrollView.contentOffset.x / CGFloat.screenWidth) + 1
        switch stage {
        case 1:
            didMoveToFirstStage(isFirstTime: firstStageFirstLaunch)
            break
        case 2:
            didMoveToSecondStage(isFirstTime: secondStageFirstLaunch)
            break
        case 3:
            didMoveToThirdStage(isFirstTime: thirdStageFirstLaunch)
            break
        case 4:
            didMoveToFourthStage(isFirstTime: fourthStageFirstLaunch)
            break
        default: break
            
        }
    }
    
}
// CAAnimationDelegate
extension OnboardingViewController {
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if self.messageImageView != nil {
            if (self.messageImageView!.layer.animationForKey("rotateOnRemoving") == anim) {
                self.messageImageView?.removeFromSuperview()
                self.messageImageView = nil
                
            }
        }
        postImageViewAnimationDidStopHelper(firstPostImageView, forKey: onRemovingFirstPostImageViewKey, anim: anim, completionHandler: { _ in
            self.firstPostImageView = nil
        })
        postImageViewAnimationDidStopHelper(secondPostImageView, forKey: onRemovingSecondPostImageViewKey, anim: anim, completionHandler: { _ in
            self.secondPostImageView = nil
        })
    }
    
    
    override func animationDidStart(anim: CAAnimation) {
        if self.messageImageView != nil {
            if (self.messageImageView!.layer.animationForKey("rotateOnRemoving") == anim) {
                self.secondStageFirstLaunch = true
            }
        }
        postImageViewAnimationDidStart(firstPostImageView, forKey: onRemovingFirstPostImageViewKey, anim: anim)
        postImageViewAnimationDidStart(secondPostImageView, forKey: onRemovingSecondPostImageViewKey, anim: anim)
    }
    
    // PostImageViewAnimationDidStopHelper
    func postImageViewAnimationDidStopHelper(postImageView: UIImageView?, forKey key: String, anim: CAAnimation, completionHandler: ()->()) {
        if postImageView != nil {
            let animation = postImageView?.layer.animationForKey(key)
            if animation == anim {
                postImageView?.removeFromSuperview()
                completionHandler()
            }
        }
    }
    
    func postImageViewAnimationDidStart(postImageView: UIImageView?, forKey key: String, anim: CAAnimation) {
        if postImageView != nil {
            if postImageView!.layer.animationForKey(key) == anim {
                self.thirdStageFirstLaunch = true
            }
        }
        
    }
}





