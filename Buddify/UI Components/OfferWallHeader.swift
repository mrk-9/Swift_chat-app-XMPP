//
//  OfferWallHeader.swift
//  Buddify
//
//  Created by Vo Duc Tung on 07/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

class OfferWallHeader: UIView {
	
    private var label1: UILabel!
	private var imageView1: UIImageView!
	private var imageView2: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
		
		imageView1 = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 0.25*self.frame.size.width, height: self.frame.size.height)))
		self.imageView1.image = UIImage(named: "Iphone1")!
		self.addSubview(imageView1)
		
        label1 = UILabel(frame: CGRect(origin: CGPoint(x: 80, y: 0), size: CGSize(width: self.frame.size.width - imageView1.frame.size.width, height: self.frame.size.height)))
        label1.textColor = UIColor.appPurpleColor()
        label1.font = UIFont.boldAppFont(10)
        label1.textAlignment = NSTextAlignment.Center
        label1.text = "DOWNLOAD APPS TO GET FREE DIAMONDS"
        self.backgroundColor = UIColor.appPinkColor()
        self.addSubview(label1)
		
		
		let text = NSMutableAttributedString.init(attributedString: label1.attributedText!)
		text.addAttribute(NSForegroundColorAttributeName, value: UIColor.appPinkColor(), range: NSMakeRange(20, 14))
		label1.attributedText = text
		
//		imageView2 = UIImageView(frame: CGRect(origin: CGPoint(x: self.frame.size.width - CGFloat.leftMargin - 25 , y: 0), size: CGSize(width: 30, height: self.frame.size.height)))
//		self.imageView2.contentMode = UIViewContentMode.ScaleAspectFill
//		self.imageView2.image = UIImage(named: "DownloadIcon")!
//		self.addSubview(imageView2)
		
		self.contentMode = UIViewContentMode.ScaleToFill
		self.backgroundColor = UIColor(red: 236, green: 240, blue: 241)
        let tapRecoginzer = UITapGestureRecognizer(target: self, action: #selector(OfferWallHeader.openOfferWall(_:)))
        self.userInteractionEnabled = true
        tapRecoginzer.numberOfTouchesRequired = 1
        tapRecoginzer.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapRecoginzer)
    }
    
    internal func openOfferWall(tapRecoginzer: UITapGestureRecognizer) {
        if NativeXSDK.isAdFetchedWithName(String.NativeXOfferWallPlacementName()) {
            NativeXSDK .showAdWithName(String.NativeXOfferWallPlacementName())
        }
    }
}
