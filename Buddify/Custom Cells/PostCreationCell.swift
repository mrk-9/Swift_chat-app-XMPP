//
//  PostCreationCell.swift
//  Buddify
//
//  Created by Tung Vo  on 06/06/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import Foundation
import KMPlaceholderTextView

///
/// Protocol PostCreationCellDelegate
/// Represents delegate of PostCreationCell class.
///
protocol PostCreationCellDelegate: NSObjectProtocol {
    func postCreationCellAddPhotoButtonTapped(cell: PostCreationCell)
    func postCreationCellPostImageViewTapped(cell: PostCreationCell)
    func postCreationCellPostStatusDidChange(cell: PostCreationCell, status: String?)
    func postCreationCellNeedsHeightUpdate(cell: PostCreationCell)
}

///
/// Class PostCreationCell
/// A cell class of creating new post.
///
class PostCreationCell: UITableViewCell {
    // Deleate
    weak var delegate: PostCreationCellDelegate?
    
    ///
    /// Maximum number of characters in a status.
    /// Default value 256.
    ///
    var maxCharacterCount = 256
    
    /// Profile image view
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoButton: HighLightButton!
    @IBOutlet weak var statusTextView: KMPlaceholderTextView!
    @IBOutlet weak var postImageView: UIImageView!

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var statusViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postImageViewHeightConstraint: NSLayoutConstraint!
    
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
        self.selectionStyle = .None
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = UIColor.blackColor()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dynamicType.imageViewTapped(_:)))
        postImageView.addGestureRecognizer(tapGestureRecognizer)
        
        // Status text view
        statusTextView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(profileImageView.frame)
    }
    
    func updateImage(image: UIImage?) {
        postImageView.image = image
        let width = postImageView.frame.width
        var height: CGFloat = 0
        
        if let _image = image {
            height = _image.size.height/_image.size.width*width
        }
        
        postImageViewHeightConstraint.constant = height
        delegate?.postCreationCellNeedsHeightUpdate(self)
    }
    
    func status() -> String? {
        return statusTextView.text
    }
    @IBAction func postButtonTapped(sender: AnyObject) {
        statusTextView.resignFirstResponder()
        delegate?.postCreationCellAddPhotoButtonTapped(self)
    }
    
    func imageViewTapped(imageView: UIImageView) {
        statusTextView.resignFirstResponder()
        delegate?.postCreationCellPostImageViewTapped(self)
    }
    
    func postImage() -> UIImage? {
        return postImageView.image
    }
}

//MARK: UITextViewDelegate
extension PostCreationCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        // Calculate height for text view
        var height: CGFloat = 0
        
        //Update counter label
        if let text = textView.text {
            counterLabel.text = "\(maxCharacterCount - text.characters.count)/\(maxCharacterCount)"
            
            height = text.heightInWidth(self.statusTextView.frame.width, font: self.statusTextView.font!) + 20
            
            if height < 38 {
                height = 38
            }
        }
        else {
            counterLabel.text = "\(maxCharacterCount)/\(maxCharacterCount)"
        }
        
        statusViewHeightConstraint.constant = height
        delegate?.postCreationCellNeedsHeightUpdate(self)
        
        delegate?.postCreationCellPostStatusDidChange(self, status: textView.text)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
}
