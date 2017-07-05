//
//  EditProfileInfoViewController.swift
//  Buddify
//
//  Created by Huy Le on 3/29/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

private var kRowSpacing: CGFloat = 10
private var kColumnSpacing: CGFloat = 10
private var kNumberOfColumns: UInt = 1

import AsyncDisplayKit

class EditProfileInfoViewController: ASViewController, EditUserInfoDataSourceDelegate {
	
	let collectionNode: ASCollectionNode
	private let _dataSource: EditUserInfoDataSource!
	private let _saveButton = HighLightButton.init(title: "Save", alignment: UIControlContentHorizontalAlignment.Right)
	
	init() {
		let flowLayout = MosaicCollectionViewLayout()
		flowLayout.numberOfColumns = kNumberOfColumns
		flowLayout.headerHeight = 0
		flowLayout.sectionInset = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
		flowLayout.interItemSpacing = UIEdgeInsets(top: kRowSpacing, left: kColumnSpacing, bottom: kRowSpacing, right: kColumnSpacing)
		flowLayout.columnSpacing = kColumnSpacing
		
		collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
		
		_dataSource = EditUserInfoDataSource(collectionNode: collectionNode)
		
		super.init(node: collectionNode)
		_dataSource.delegate = self
		
	}
	
	override func loadView() {
		super.loadView()
		
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Edit Info"
		
		_saveButton.addTarget(self, action: #selector(EditProfileInfoViewController._saveButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
		let rightBarButton = UIBarButtonItem(customView: _saveButton)
		self.navigationItem.rightBarButtonItem = rightBarButton
		_saveButton.enabled = false
		DTLog(self.collectionNode.view.frame)
		let viewTapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditProfileInfoViewController.dismissKeyboard))
		self.view.addGestureRecognizer(viewTapped)
		
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(EditProfileInfoViewController.keyboardWillChangeFrame(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
        self.setEditing(false, animated: true)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)

	}
	
	//MARK: Action methods
	//MARK: Keyboard frame change notification
	internal func keyboardWillChangeFrame(notification : NSNotification){
		var userInfo = notification.userInfo!
		
		let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue
		
		var collectionNodeFrame = collectionNode.frame
		collectionNodeFrame.size.height = frameEnd.origin.y - 64
		
		//Change share bar frame
		
		let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntValue

		UIView.animateWithDuration(
			userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue,
			delay: 0,
			options: UIViewAnimationOptions(rawValue: UInt(curve)),
			animations: {
				self.collectionNode.view.frame = collectionNodeFrame
				self.node.setNeedsDisplay()
			},
			completion: {(flag) -> Void in (
				DTLog(self.collectionNode.view.frame)
				)}
		)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func _saveButtonTapped() {
		_saveButton.enabled = false
		self.view.endEditing(true)
	}
	
	internal func editUserInfoDataSourceTextUpdating() {
		_saveButton.enabled = true

	}
	
	func editUserInfoDataSourceTextBeginUpdating() {
		
	}
	
	func dismissKeyboard() {
		self.view.endEditing(true)
	}
	
}