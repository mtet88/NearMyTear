//
//  LocationManager.swift
//  TheRightFit
//
//  Created by Mauricio Torres Mejia on 23.05.21.
//

import Foundation
import CoreLocation
import UserNotifications

class LocationManager: NSObject {
    
    private static var singleton: LocationManager?
    public static var shared: LocationManager {
        
        if let _singleton = self.singleton {
            return _singleton
        }
        
        let newSingleton = LocationManager()
        newSingleton.locationManager.delegate = newSingleton
        
        self.singleton = newSingleton
        return self.shared
    }
    
    private let locationManager = CLLocationManager()
    private (set) var lastKnownLocation: CLLocation?
    private var permissionCallbacks = [(Bool) -> Void]()
    private var isPermissionAlreadyGranted : Bool {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse,
             .authorizedAlways: return true
        default:                return false
        }
    }
    
    func requestPermission(granted: @escaping (Bool) -> Void) {
        self.permissionCallbacks.append(granted)
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse,
             .authorizedAlways:
            
            self.locationManager.startUpdatingLocation()
            self.trigger(callbacks: self.permissionCallbacks, for: true)
            self.permissionCallbacks.removeAll()
            
        case .notDetermined:
            
            self.locationManager.requestWhenInUseAuthorization()
        
        default:
            
            self.trigger(callbacks: self.permissionCallbacks, for: false)
            self.permissionCallbacks.removeAll()
        }
    }
    
    private func trigger(callbacks: [(Bool) -> Void], for statusGranted: Bool) {

        var callbacks = callbacks
        guard let _callback = callbacks.popLast() else {
            return
        }
        
        _callback(statusGranted)
        
        self.trigger(callbacks: callbacks, for: statusGranted)
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let _newLocation = locations.first {
            self.lastKnownLocation = _newLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        let granted : Bool
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:    return
        case .authorizedWhenInUse,
             .authorizedAlways:
            
            granted = true
            self.locationManager.startUpdatingLocation()
        
        default:                granted = false
        }
        
        self.trigger(callbacks: self.permissionCallbacks, for: granted)
        self.permissionCallbacks.removeAll()
    }
}
