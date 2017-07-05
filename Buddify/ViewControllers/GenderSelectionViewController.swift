//
//  GenderSelectionViewController.swift
//  Buddify
//
//  Created by Tung Vo  on 07/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import Models

private let cellIdentifier = "Cell"

///
/// Protocol GenderSelectionViewControllerDelegate
///
protocol GenderSelectionViewControllerDelegate: NSObjectProtocol {
    func genderSelectionViewControllerDidChangeGender(viewController: GenderSelectionViewController, gender: BDFUserGender)
}


///
/// Class GenderSelectionViewController
/// Used when user needs to change gender.
///
class GenderSelectionViewController: UITableViewController {
    ///
    /// Delegate
    ///
    weak var delegate: GenderSelectionViewControllerDelegate?
    
    var originalGender: BDFUserGender = .Male {
        didSet {
            currentGender = originalGender
        }
    }
    
    private var currentGender: BDFUserGender = .Male

    init() {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gender selection"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        self.tableView.allowsMultipleSelection = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "GenderSelectionCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.scrollEnabled = false
        self.tableView.estimatedRowHeight = 60
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GenderSelectionCell
        cell.genderLabel.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        
        // Configure the cell...
        if indexPath.row == 0 {
            cell.genderLabel.text = "Male"
        }
        else if indexPath.row == 1 {
            cell.genderLabel.text = "Female"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if currentGender != .Male {
                currentGender = .Male
                self.tableView.reloadData()
                self.updateUserGender(currentGender)
            }
        }
        else {
            if currentGender != .Female {
                currentGender = .Female
                self.tableView.reloadData()
                self.updateUserGender(currentGender)
            }
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            cell.accessoryType = (currentGender == .Male) ? .Checkmark : .None
        }
        else {
            cell.accessoryType = currentGender == .Female ? .Checkmark : .None
        }
    }
    
    private func updateUserGender(gender: BDFUserGender) {
        BDFAuthenticatedUser.currentUser.updateUserInformation(name: nil, username: nil, birthdate: nil, bio: nil, gender: gender, profileImage: nil, progressBlock: nil, successBlock: { (user: User?) in
            // Do nothing because the user object has already been updated
            // Update original gender after a success call
            self.originalGender = gender
            
            // Call delegate method
            self.delegate?.genderSelectionViewControllerDidChangeGender(self, gender: gender)
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            // Reset gender
            self.currentGender = self.originalGender
            
            // Show error
            if statusCode == 1 {
                let alertController = UIAlertController(title: nil, message: "Cannot change gender. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                    
                })
                alertController.addAction(cancelButton)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: nil, message: "You have used all 3 times. It is no more possible to change your gender.", preferredStyle: UIAlertControllerStyle.Alert)
                let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                    
                })
                alertController.addAction(cancelButton)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
