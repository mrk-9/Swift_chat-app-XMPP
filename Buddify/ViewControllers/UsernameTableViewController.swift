//
//  UsernameTableViewController.swift
//  Buddify
//
//  Created by Tung Vo  on 08/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import Models

private let cellIdentifier = "Cell"

///
/// Protocol UsernameTableViewControllerDelegate
///
protocol UsernameTableViewControllerDelegate: NSObjectProtocol {
    func usernameTableViewControllerDidUpdateUsername(viewController: UsernameTableViewController, username: String)
}

///
/// Class UsernameTableViewController
/// Used to give user option to change their username.
///
class UsernameTableViewController: UITableViewController {
    weak var delegate: UsernameTableViewControllerDelegate?
    var currentUsername: String!
    
    init() {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Username"
        
        self.tableView.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.scrollEnabled = false
        self.tableView.estimatedRowHeight = 60
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextFieldTableViewCell
        
        cell.textField.font = UIFont.appFont(CGFloat.normalFontSize)
        cell.textField.placeholder = "Your private username"
        cell.textField.textAlignment = .Center
        cell.textField.returnKeyType = .Done
        cell.textField.tintColor = UIColor.appPurpleColor()
        cell.textField.delegate = self
        cell.textField.text = currentUsername

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Your username is only visible to you.\nSet your own username and make it easier to login.\nUsername should only contain characters, number, underscore(_) and dot(.) and be at least 6 characters long."
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

//MARK: UITextFieldDelegate
extension UsernameTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // DIsmiss keyboard
        textField.resignFirstResponder()
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? TextFieldTableViewCell {
            // Update username
            if let newUsername = cell.string() {
                // Check if new username is different from current one.
                if currentUsername != newUsername {
                    let validator = UsernameValidatior()
                    // Validate username
                    let result = validator.validateUsername(newUsername)
                    
                    // If username is valid
                    switch result {
                        
                    case .Valid:
                        // Send request
                        BDFAuthenticatedUser.currentUser.updateUserInformation(name: nil, username: newUsername, birthdate: nil, bio: nil, gender: nil, profileImage: nil, progressBlock: nil, successBlock: { (user: User?) in
                            // Pop view controller and call delegate method
                            self.navigationController?.popViewControllerAnimated(true)
                            self.delegate?.usernameTableViewControllerDidUpdateUsername(self, username: newUsername)
                            
                            }, failureBlock: { (statusCode: Int?, errorCode: Int?, error: NSError?) in
                                // Check if username is taken
                                if error?.code == NSURLErrorNotConnectedToInternet {
                                    let internetAlertController = UIAlertController.internetConnectionAlertController(nil)
                                    self.presentViewController(internetAlertController, animated: true, completion: {
                                        
                                    })
                                }
                                else {
                                    if errorCode == 1 {
                                        // Username taken
                                        let alertController = UIAlertController(title: nil, message: "\(newUsername) is already taken. Please choose a new one.", preferredStyle: UIAlertControllerStyle.Alert)
                                        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                                        alertController.addAction(button)
                                        self.presentViewController(alertController, animated: true, completion: nil)
                                        
                                    }
                                    else if statusCode != nil {
                                        let alertController = UIAlertController(title: nil, message: "Something when wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                                        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                                        alertController.addAction(button)
                                        self.presentViewController(alertController, animated: true, completion: nil)
                                    }
                                }
                        })
                        
                    case .InvalidChar:
                        // Contain invalid char
                        let alertController = UIAlertController(title: nil, message: "Username has invalid char. Please read instruction below.", preferredStyle: UIAlertControllerStyle.Alert)
                        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(button)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    case .InvalidFirstChar:
                        // First char is not a letter
                        let alertController = UIAlertController(title: nil, message: "Username can only start with a letter.", preferredStyle: UIAlertControllerStyle.Alert)
                        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(button)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    case .LessThanRequiredLegth:
                        // Lenght of username is too short
                        let alertController = UIAlertController(title: nil, message: "Username should contain at least \(validator.numberOfChars) character. Please read instruction below.", preferredStyle: UIAlertControllerStyle.Alert)
                        let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                        alertController.addAction(button)
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
            }
            else {
                
            }
        }
        
        return true
    }
}
