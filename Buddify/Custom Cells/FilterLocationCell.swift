//
//  FilterLocationCell.swift
//  Buddify
//
//  Created by Tung Vo  on 02/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation

/// Protocol FilterLocationCellDelegate
protocol FilterLocationCellDelegate: NSObjectProtocol {
    func filterLocationCellButtonTapped(cell: FilterLocationCell)
}

/// Class FilterLocationCell
class FilterLocationCell: UITableViewCell {
    weak var delegate: FilterLocationCellDelegate?
    @IBOutlet weak var _label: UILabel!
    @IBOutlet weak var _locationButton: HighLightButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    private func commonInit() {
        _label.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        _label.textColor = UIColor.appPurpleColor()
        
        _locationButton.titleLabel?.font = UIFont.boldAppFont(CGFloat.normalFontSize)
        _locationButton.layer.cornerRadius = 5
        _locationButton.layer.masksToBounds = true
        _locationButton.backgroundColor = UIColor.appPurpleColor()
    }
    
    func setLocationName(name: String) {
        _locationButton.setTitle(name, forState: UIControlState.Normal)
    }
    
    @IBAction func locationButtonTapped(sender: AnyObject) {
        delegate?.filterLocationCellButtonTapped(self)
    }
    
    class func defaultHeight() -> CGFloat {
        return 106
    }
}
