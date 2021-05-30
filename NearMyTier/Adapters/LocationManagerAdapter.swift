//
//  LocationManagerAdapter.swift
//  TheRightFit
//
//  Created by Mauricio Torres Mejia on 24.05.21.
//

import Foundation
import CoreLocation

struct LocationManagerAdapter: LocationService {
  
    var locationManager: LocationManager
    var onGranted: (() -> Void)?
    var onDenied: (() -> Void)?
    var onLocationUpdate: (() -> Void)?
    
    init(locationManager: LocationManager, onGranted: (() -> Void)? = nil, onDenied: (() -> Void)? = nil, onLocationUpdate: (() -> Void)? = nil) {
        self.locationManager = locationManager
        self.onGranted = onGranted
        self.onDenied = onDenied
        self.onLocationUpdate = onLocationUpdate
    }

    var lastKnownLocation: CLLocation? {
        return self.locationManager.lastKnownLocation
    }
    
    func requestPermition() {
        self.locationManager.requestPermission { (granted: Bool) in
            (granted == true) ? onGranted?() : onDenied?()
        }
    }
}
