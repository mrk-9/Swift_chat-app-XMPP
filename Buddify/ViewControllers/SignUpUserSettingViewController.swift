//
//  SignUpUserSettingViewController.swift
//  Buddify
//
//  Created by Huy Le on 3/27/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SignUpUserSettingViewController: ASViewController, ASTableDataSource, ASTableDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	private let tableNode = ASTableNode()
	
	private var profileImage: UIImage?
	private var gender: Bool? //female: false, male: true
	private var birthdate: NSDate?
	private var age: Int?

		
	init() {
		super.init(node: tableNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		super.loadView()
		self.extendedLayoutIncludesOpaqueBars = true
		self.automaticallyAdjustsScrollViewInsets = false
		
		//Load table node
		tableNode.frame = CGRect(x: 0, y: 0, width: self.node.bounds.width, height: self.node.bounds.height)
		tableNode.view.separatorStyle = UITableViewCellSeparatorStyle.None
		tableNode.view.scrollEnabled = false
		tableNode.delegate = self
		tableNode.dataSource = self
	
	}
	
	override func layoutSublayersOfLayer(layer: CALayer) {
		super.layoutSublayersOfLayer(layer)
		
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.appGrayColor()
		self.navigationItem.hidesBackButton = false
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		print("will load")
		
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		
	}
	
	//MARK: ASTableViewDataSource
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(tableView: ASTableView, nodeBlockForRowAtIndexPath indexPath: NSIndexPath) -> ASCellNodeBlock {
		return {
			if indexPath.row == 0 {
				let node = SignUpSettingNode()
				node.backgroundColor = UIColor.appPinkColor()
				return node
			}
			else if indexPath.row == 1 {
				return ProfilePhotoNode()
			}
			else if indexPath.row == 2 {
				
				let node = ProfileGenderNode()
				node.backgroundColor = UIColor.appPinkColor()
				node.changeGenderBlock = {(gender: Bool) -> Void in self.gender = gender}
				return node
			}
			else if indexPath.row == 3 {
				return ProfileBirthdayNode()
			}
			else {
				return GetStartedNode()
			}
		}
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: false)
		//get started selected
		if indexPath.row == 1 {
			//Image picker
			let alertController = UIAlertController.imagePickerAlertController(delegate: self, viewController: self)
			self.presentViewController(alertController, animated: true, completion: nil)
		}
		else if indexPath.row == 3 {
			//Date picker
			let datePickerViewController = AIDatePickerController.pickerWithDate(NSDate(), selectedBlock: { (date: NSDate!) -> Void in
				//Get the date and age
				if let node = self.tableNode.view.nodeForRowAtIndexPath(indexPath) as? ProfileBirthdayNode {
					self.birthdate = date
					node.setDate(date)
					self.age = NSDate.calculateAge(date)
					print(self.age)
					node.ageText.setTitle("\(self.age!)Y", withFont: UIFont.boldAppFont(12), withColor: UIColor.whiteColor(), forState: ASControlState.Normal)
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
		else if indexPath.row == 4 {
			
			guard let _gender = gender else {
				let alertController = UIAlertController(title: "Info missing!", message: "Please select your gender", preferredStyle: UIAlertControllerStyle.Alert)
				let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
					
				})
				alertController.addAction(cancelButton)
				self.presentViewController(alertController, animated: true, completion: nil)
				
				return
			}
			
			guard let _birthdate = birthdate else {
				let alertController = UIAlertController(title: "Info missing!", message: "Please select your birthday to proceed", preferredStyle: UIAlertControllerStyle.Alert)
				let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
					
				})
				alertController.addAction(cancelButton)
				self.presentViewController(alertController, animated: true, completion: nil)
				
				return
			}
			
			guard let _ = profileImage else {
				let alertController = UIAlertController(title: "Info missing!", message: "Please select your profile image to proceed", preferredStyle: UIAlertControllerStyle.Alert)
				let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
					
				})
				alertController.addAction(cancelButton)
				self.presentViewController(alertController, animated: true, completion: nil)
				return
			}
			
			DTLog("\(_gender) \(_birthdate) profile")

			//Update user info
			let user = User()
			let genderInt = (gender != nil) ? 0 : 1
			
//			UserService.updateProfileInfo(username: user.username, birthdate: self.birthdate?.birthdayString, gender: genderInt, bio: nil, latitude: nil, longitude: nil, hometown: nil, lookFor: nil, languages: nil, progress: nil, success: { (task, object) in
//				
//					if let result = object as? NSDictionary {
//						DTLog(result)
//					}
//				
//				}, failure: { (task, object) in
//					if let response = task?.response as? NSHTTPURLResponse {
//						if response.statusCode != 200 {
//							DTLog(response.statusCode)
//						}
//					}
//			})
			
			UserService.updateProfilePhoto(NSData.init(data: UIImagePNGRepresentation(self.profileImage!)!), progress: nil, success: { (task, object) in
				
				if let result = object as? NSDictionary {
					
					DTLog(result)
					
				}
				
			}, failure: { (task, object) in
				if let response = task?.response as? NSHTTPURLResponse {
					if response.statusCode != 200 {
						DTLog(response.statusCode)
					}
				}
			})
			
			let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
			let userTabbarController = UserTabbarController()
			appDelegate.window?.rootViewController = userTabbarController
			appDelegate.window?.makeKeyAndVisible()
			self.dismissViewControllerAnimated(true, completion: {
				DTLog("load app")
			})
		}
	}
	
	//MARK: UIImagePickerControllerDelegate
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		self.dismissViewControllerAnimated(true, completion: nil)
		
		//set image picked
		if let node = tableNode.view.nodeForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as? ProfilePhotoNode {
			if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
				node.profileImageNode.image = image
				profileImage = image
			}
			else {
				if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
					node.profileImageNode.image = image
					profileImage = image
				}
			}
		}

	}
	
}
