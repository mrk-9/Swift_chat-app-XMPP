//
//  GenderSelectionCell.swift
//  Buddify
//
//  Created by Tung Vo  on 07/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import UIKit


///
/// Class GenderSelectionCell
/// Used when need to show user gender selection.
///
class GenderSelectionCell: UITableViewCell {
    @IBOutlet weak var genderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }
}
