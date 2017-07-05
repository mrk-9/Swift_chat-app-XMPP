//
//  UserLocationUtility.swift
//  Dispot
//
//  Created by Huy Le on 3/19/15.
//  Copyright (c) 2015 MacBook Pro. All rights reserved.
//

import Foundation

@objc protocol UserLocationUtilityDelegate{
    optional func userLocationUtilityPresentViewController(alertController: UIAlertController)
    
    // This method might be called multiple times
    func userLocationUtilityDidGetLocation(location: CLLocation)
}

class UserLocationUtility: NSObject,CLLocationManagerDelegate{
    private var locationManager : CLLocationManager!
    var delegate: UserLocationUtilityDelegate?
    
    static var sharedInstance: UserLocationUtility {
        struct Singleton {
            static let instance = UserLocationUtility()
        }
        
        return Singleton.instance
    }
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager.distanceFilter = 500
        locationManager.delegate = self
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getUserLocation(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
            case CLAuthorizationStatus.AuthorizedWhenInUse, CLAuthorizationStatus.AuthorizedAlways:
                self.locationManager.startUpdatingLocation()
                
            case .Denied:
                let alertController = UIAlertController(title: "Permission denied", message: "Buddify is not given permission to access your location. Please go to Settings ‣ Privacy ‣ Location Services and turn on for Dispot", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                    
                }))
                
                delegate?.userLocationUtilityPresentViewController?(alertController)
            
            case .NotDetermined:
                self.locationManager.requestWhenInUseAuthorization()
                
            case .Restricted:
                NSLog("Restricted")
            }
        }
        else {
            let alertController = UIAlertController(title: "Location services disabled", message: "Location services is disabled on your device. Please go to Settings ‣ Privacy ‣ Location Services and turn it on.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                
            }))
            
            delegate?.userLocationUtilityPresentViewController?(alertController)
        }
    }
    
    //MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            delegate?.userLocationUtilityDidGetLocation(locations.first!)
        }
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.AuthorizedWhenInUse, CLAuthorizationStatus.AuthorizedAlways:
                manager.startUpdatingLocation()
                
        case .Denied:
            let alertController = UIAlertController(title: "Permission denied", message: "Buddify is not given permission to access your location. Please go to Settings ‣ Privacy ‣ Location Services and turn on for Buddify", preferredStyle: UIAlertControllerStyle.Alert)
                
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                    
            }))
            delegate?.userLocationUtilityPresentViewController?(alertController)

        case .NotDetermined:
            DTLog("Not determined")
                manager.requestWhenInUseAuthorization()
                
        case .Restricted:
            DTLog("Restricted")
        }
    }
    
    // Get authorization status
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
}