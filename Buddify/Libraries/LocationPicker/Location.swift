//
//  Location.swift
//  LocationPicker
//
//  Created by Almas Sapargali on 7/29/15.
//  Copyright (c) 2015 almassapargali. All rights reserved.
//

import Foundation

import CoreLocation
import AddressBookUI

private let coordinateKey = "coordinate"
private let nameKey = "name"
private let locationKey = "location"
private let placemarkKey = "placemark"
private let archivedLocationsKey = "Locations"
private let locationsPathComponent = "DiscoverySearchLocation"

public protocol BDFDiscoveryLocation: NSObjectProtocol {
    var name: String? { get set}
    
    // difference from placemark location is that if location was reverse geocoded,
    // then location point to user selected location
    var location: CLLocation! { get set}
    var placemark: CLPlacemark! { get set}
    var address: String { get }
    var coordinate: CLLocationCoordinate2D { get }
}

// class DiscoverySearchLocation
public class DiscoverySearchLocation: NSObject, BDFDiscoveryLocation, NSCoding {
	public var name: String?
	
	// difference from placemark location is that if location was reverse geocoded,
	// then location point to user selected location
	public var location: CLLocation!
	public var placemark: CLPlacemark!
	
	public var address: String {
		// try to build full address first
		if let addressDic = placemark.addressDictionary {
            // Create a user-friendly address string
            var locations = [String]()
            
            for i in 0...5 {
                // Ignore country
                if i == 0 {
                    if let country = addressDic["State"] as? String {
                        locations.insert(country, atIndex: 0)
                    }
                }
                else if i == 1 {
                    if let country = addressDic["SubLocality"] as? String {
                        locations.insert(country, atIndex: 0)
                    }
                }
                else if i == 2 {
                    if let country = addressDic["City"] as? String {
                        locations.insert(country, atIndex: 0)
                    }
                }
                else if i == 3 {
                    if let country = addressDic["Thoroughfare"] as? String {
                        locations.insert(country, atIndex: 0)
                    }
                }
                else if i == 4 {
                    if let country = addressDic["Street"] as? String {
                        locations.insert(country, atIndex: 0)
                    }
                }
                
                if locations.count >= 2 {
                    break
                }
            }
            
            return locations.joinWithSeparator(", ")
            
//			if let lines = addressDic["FormattedAddressLines"] as? [String] {
//				return lines.joinWithSeparator(", ")
//			} else {
//				// fallback
//				return ABCreateStringWithAddressDictionary(addressDic, true)
//			}
		} else {
			return "\(coordinate.latitude), \(coordinate.longitude)"
		}
	}
	
	public init(name: String?, location: CLLocation? = nil, placemark: CLPlacemark) {
		self.name = name
		self.location = location ?? placemark.location!
		self.placemark = placemark
	}
    
    public func encodeWithCoder(aCoder: NSCoder) {
        if let _name = name {
            aCoder.encodeObject(_name, forKey: nameKey)
        }
        aCoder.encodeObject(location, forKey: locationKey)
        aCoder.encodeObject(placemark, forKey: placemarkKey)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init()
        placemark = aDecoder.decodeObjectForKey(placemarkKey) as! CLPlacemark
        location = aDecoder.decodeObjectForKey(locationKey) as? CLLocation ?? placemark.location!
        name = aDecoder.decodeObjectForKey(nameKey) as? String
    }
}

import MapKit

extension DiscoverySearchLocation: MKAnnotation {
    @objc public var coordinate: CLLocationCoordinate2D {
		return location.coordinate
	}
	
    public var title: String? {
		return name ?? address
	}
}

///
/// Class DiscoverySearchLocationProvider
///
private var selectedLocationIndexKey = "selected_location_index"
class DiscoverySearchLocationProvider {
    /// Default provider
    static var defaultProvider: DiscoverySearchLocationProvider {
        struct Singleton {
            static var provider: DiscoverySearchLocationProvider!
        }
        
        if Singleton.provider == nil {
            Singleton.provider = DiscoverySearchLocationProvider()
            Singleton.provider._currentLocations = DiscoverySearchLocationArchiver.sharedInstance.retrieveLocations(forKey: archivedLocationsKey, pathComponent: locationsPathComponent)
            Singleton.provider._selectedLocationIndex = NSUserDefaults.standardUserDefaults().integerForKey(selectedLocationIndexKey)
        }
        
        return Singleton.provider
    }
    
    // Access array of current locations
    var currentLocations: [DiscoverySearchLocation] {
        return _currentLocations
    }
    
    /// Return selected location for discovery
    var selectedLocation: DiscoverySearchLocation? {
        if _selectedLocationIndex < 0 || _selectedLocationIndex >= _currentLocations.count {
            return nil
        }
        
        return _currentLocations[_selectedLocationIndex]
    }
    
    // Save current locations to disk
    func saveLocations(locations: [DiscoverySearchLocation], selectedIndex: Int) {
        _currentLocations = locations
        self.activateLocationAtInex(selectedIndex)
        
        DiscoverySearchLocationArchiver.sharedInstance.saveLocations(_currentLocations, forKey: archivedLocationsKey, pathComponent: locationsPathComponent)
        NSUserDefaults.standardUserDefaults().setInteger(selectedIndex, forKey: selectedLocationIndexKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Always retrieve current locations from disk
    private var _currentLocations: [DiscoverySearchLocation]!
    
    // Selected location index
    private var _selectedLocationIndex: Int = -1
    
    // Activate the current selected location
    // Use -1 for current user location
    private func activateLocationAtInex(index: Int) {
        // if index is out of array bound, activate location and bring it to first position
        if _currentLocations.count > index && index >= 0{
            let location = _currentLocations.removeAtIndex(index)
            _currentLocations.insert(location, atIndex: 0)
            _selectedLocationIndex = 0
        }
        else {
            _selectedLocationIndex = -1
        }
    }
}

private class DiscoverySearchLocationArchiver: DTArchirverHelper {
    static var sharedInstance: DiscoverySearchLocationArchiver {
        struct Singleton {
            static var archiver = DiscoverySearchLocationArchiver(folderPath: DTArchirverHelper.cachesInstance.folderPath)
        }
        
        return Singleton.archiver
    }
    
    func saveLocations(locations: [DiscoverySearchLocation]?, forKey key: String, pathComponent : String) {
        self.saveObjectData(locations, forKey: key, pathComponent: pathComponent)
    }
    
    func retrieveLocations(forKey key: String, pathComponent : String) -> [DiscoverySearchLocation] {
        if let locations = self.retrieveObjectForKey(key, pathComponent: pathComponent) as? [DiscoverySearchLocation] {
            return locations
        }
        
        // This is user's current location as coordinate is nil
        return []
    }
}