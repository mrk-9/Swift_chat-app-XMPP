//
//  PasswordTableViewController.swift
//  Buddify
//
//  Created by Tung Vo  on 07/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit
import Models

private let cellIdentifier = "Cell"

class PasswordTableViewController: UITableViewController {
    
    private var saveButton: HighLightButton = HighLightButton(title: "Save", alignment: UIControlContentHorizontalAlignment.Right)
    
    private var cells: [TextFieldTableViewCell]!
    
    init() {
        super.init(style: UITableViewStyle.Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Password"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.backgroundColor = UIColor.appScrollViewBackgrouncColor()
        self.tableView.allowsMultipleSelection = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerNib(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.scrollEnabled = false
        self.tableView.estimatedRowHeight = 60
        self.clearsSelectionOnViewWillAppear = false
        
        // Right bar button item - Save
        saveButton.addTarget(self, action: #selector(self.dynamicType._saveButtonTapped), forControlEvents: UIControlEvents.TouchUpInside)
        let barButtonItem = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = barButtonItem
        saveButton.enabled = false
        
        // Make array
        cells = []
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cells[0].textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TextFieldTableViewCell
        
        cell.textField.font = UIFont.appFont(CGFloat.normalFontSize)
        cell.textField.secureTextEntry = true
        cell.textField.delegate = self
        
        if indexPath.row >= cells.count {
            cells.append(cell)
        }
        else {
            cells[indexPath.row] = cell
        }

        // Configure the cell...
        if indexPath.row == 0 {
            cell.textField.returnKeyType = .Next
            cell.textField.placeholder = "Current password"
        }
        else if indexPath.row == 1 {
            cell.textField.placeholder = "New password"
            cell.textField.returnKeyType = .Next
        }
        else {
            cell.textField.placeholder = "Reenter new password"
            cell.textField.returnKeyType = .Done
        }

        return cell
    }
    
    internal func _saveButtonTapped() {
        //Check if any text field is empty
        for (index, cell) in cells.enumerate() {
            if cell.isEmpty() {
                var message: String
                if index == 0 {
                    message = "Please enter current password"
                }
                else if index == 0 {
                    message = "Please enter new password"
                }
                else {
                    message = "Please repeat new password"
                }
                let alertController = UIAlertController(title: "Oops", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                    
                })
                alertController.addAction(cancelButton)
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
        }
        
        guard let oldPassword = cells[0].string() else {
            return
        }
        
        guard let newPassword = cells[1].string() else {
            return
        }
        
        //Check new passwords match
        if cells[1].string() != cells[2].string() {
            let alertController = UIAlertController(title: "Oops", message: "New password does not match", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        //Check if password is less than 6 characters
        if newPassword.characters.count < 6 {
            let alertController = UIAlertController(title: "Oops", message: "Password should be more than 6 characters", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        //Check if password has space
        if newPassword.containsString(" ") {
            let alertController = UIAlertController(title: "Oops", message: "Password should not contain white space", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            })
            alertController.addAction(cancelButton)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        // Change password
        BDFAuthenticatedUser.currentUser.updatePasswordWithOldPassword(oldPassword, newPassword: newPassword, successBlock: {
            // Password has been updated
            let alertController = UIAlertController(title: nil, message: "Password updated", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alertController.addAction(action)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }) { (statusCode: Int?, errorCode: Int?, error: NSError?) in
            if error?.code == NSURLErrorNotConnectedToInternet {
                let internetAlertController = UIAlertController.internetConnectionAlertController(nil)
                self.presentViewController(internetAlertController, animated: true, completion: {
                    
                })
            }
            else {
                if errorCode == 12 {
                    // Current password is wrong
                    let alertController = UIAlertController(title: nil, message: "Old password is incorrect.", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) in
                        
                    })
                    alertController.addAction(action)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else {
                    // Password could not be updated
                    let alertController = UIAlertController(title: nil, message: "Something went wrong. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) in
                        
                    })
                    alertController.addAction(action)
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
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

//MARK: UITextFieldDelegate
extension PasswordTableViewController: UITextFieldDelegate {
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == cells[0].textField {
            cells[1].textField.becomeFirstResponder()
        }
        else if textField == cells[1].textField {
            cells[2].textField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var strings : [String] = []
        //Get updated text in text field
        if let newText = (textField.text as NSString?)?.stringByReplacingCharactersInRange(range, withString: string) {
            //Checking if updating text field t? add the correct string to password array
            for i in 0...2 {
                if textField == cells[i].textField {
                    strings.append(newText)
                }
                else {
                    strings.append(cells[i].textField.text!)
                }
            }
            
            var noEmptyField = true
            for string in strings {
                if string.characters.count == 0 {
                    noEmptyField = false
                    break
                }
            }
            
            if noEmptyField {
                saveButton.enabled = true
            }
            else {
                saveButton.enabled = false
            }
        }
        return true
    }
}
