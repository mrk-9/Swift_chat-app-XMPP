# DTParallaxScrollViewController

[![CI Status](http://img.shields.io/travis/Tung Vo/DTParallaxScrollViewController.svg?style=flat)](https://travis-ci.org/Tung Vo/DTParallaxScrollViewController)
[![Version](https://img.shields.io/cocoapods/v/DTParallaxScrollViewController.svg?style=flat)](http://cocoapods.org/pods/DTParallaxScrollViewController)
[![License](https://img.shields.io/cocoapods/l/DTParallaxScrollViewController.svg?style=flat)](http://cocoapods.org/pods/DTParallaxScrollViewController)
[![Platform](https://img.shields.io/cocoapods/p/DTParallaxScrollViewController.svg?style=flat)](http://cocoapods.org/pods/DTParallaxScrollViewController)

## Example
DTParallaxScrollView is a custom UIView that creates parallax scroll view vertical effects. You can use it to apply the effect to your UITableView or UICollectionView or UIScrollView in general. 

For example, if you want to have a map view on top of a table view and you want to be able to interact with both the map view and table view without any conflictions.

You can subclass DTParallaxScrollViewController, and then call this in initializer:
```
super.init(scrollView: tableView, headerHeight: kHeaderHeight)
```
where scrollView is the view you want to apply parallax effect and headerHeight is height of header.

set delegate for parallax scroll view controller
```
self.delegate = object
```

conforms DTParallaxScrollViewDelegate in deleget object
```
func parallaxScrollViewViewForHeader(viewController: DTParallaxScrollView) -> UIView {
    return mapView
}
```

Here is how you make parallax effect
```
self.updateBlock = {(yOffset: CGFloat, visible: Bool) -> Void in
    if yOffset < 0 {
        let scaleFactor = 1 + abs(yOffset/self.headerHeight)
        self._mapView.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
    }
    else {
        self._mapView.transform = CGAffineTransformIdentity
    }
}
```

Instead of using DTParallaxScrollViewController, you can also use DTParallaxScrollView to achieve the same effect.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DTParallaxScrollViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DTParallaxScrollViewController"
```

## Author

Tung Vo, tung98.dn@gmail.com

## License

DTParallaxScrollViewController is available under the MIT license. See the LICENSE file for more info.
