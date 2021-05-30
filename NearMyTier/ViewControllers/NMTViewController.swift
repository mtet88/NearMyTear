//
//  NMTViewController.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import UIKit
import Foundation

class NMTViewController: UIViewController {
    
}

extension NMTViewController {
    
    static func makeMapViewController() -> MapViewController? {
        
        let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
        
        let locationAdapter = LocationManagerAdapter(locationManager: LocationManager.shared, onLocationUpdate: {
            
        })
        
        mapViewController?.locationService = locationAdapter

        return mapViewController
    }
    
    static func makeLocationPermissionViewController() -> LocationPermissionViewController? {
        
        let locationPermissionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationPermissionViewController") as? LocationPermissionViewController
        
        let locationAdapter = LocationManagerAdapter(locationManager: LocationManager.shared) { [weak locationPermissionViewController] in
            locationPermissionViewController?.showCardsViewController()
        } onDenied: { [weak locationPermissionViewController] in
            locationPermissionViewController?.showSettingsButtonAndInfo()
        }
        
        locationPermissionViewController?.service = locationAdapter

        return locationPermissionViewController
    }
}
