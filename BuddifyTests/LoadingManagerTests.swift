//
//  LoadingManagerTests.swift
//  Buddify
//
//  Created by Vo Duc Tung on 01/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

import XCTest
@testable import Buddify

//class LoadingManagerTests: XCTestCase {
//    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight))
//    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        //scrollView.addLoadingManager()
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//        scrollView.removeLoadingManager()
//    }
//    
//    func testLoaderNotAnimationAfterAdding() {
//        let result = scrollView.loadingManager!.loader.isAnimating()
//        XCTAssertEqual(false, result)
//    }
//    
//    func testLoaderIsAnimating() {
//        scrollView.startLoading()
//        let result = scrollView.loadingManager!.loader.isAnimating()
//        XCTAssertEqual(true, result)
//    }
//    
//    func testLoaderStopsAnimatingAfterApplicationResignsActive() {
//        NSNotificationCenter.defaultCenter().postNotificationName(UIApplicationWillResignActiveNotification, object: nil)
//        let result = scrollView.loadingManager!.loader.isAnimating()
//        XCTAssertEqual(false, result)
//    }
//    
//    func testLoaderIsAnimatingAtBottom() {
//        scrollView.contentSize = CGSize(width: 0, height: 100 * CGFloat.screenHeight)
//        scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
//        let result = scrollView.loadingManager!.loader.isAnimating()
//        XCTAssertEqual(true, result)
//    }
//    
//    func testLoaderInCorrectPosition() {
//        scrollView.contentSize = CGSize(width: 0, height: 100 * CGFloat.screenHeight)
//        let result = scrollView.loadingManager!.loader.frame.origin.y == scrollView.contentSize.height + ((scrollView.contentInset.bottom - 49) - scrollView.loadingManager!.loader.frame.size.height)/2
//        XCTAssertEqual(true, result)
//    }
//}
