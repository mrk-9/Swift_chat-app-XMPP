//
//  TextFieldTableViewCell.swift
//  Buddify
//
//  Created by Tung Vo  on 07/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isEmpty() ->  Bool{
        return textField.text == nil || textField.text!.isEmpty
    }
    
    func string() ->  String? {
        return textField.text
    }
    
}