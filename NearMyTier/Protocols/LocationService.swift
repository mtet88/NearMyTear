//
//  LocationService.swift
//  TheRightFit
//
//  Created by Mauricio Torres Mejia on 23.05.21.
//

import Foundation
import CoreLocation

protocol LocationService {
    
    var onGranted: (() -> Void)? { get }
    var onDenied: (() -> Void)? { get }
    var onLocationUpdate: (() -> Void)? { get }
    var lastKnownLocation: CLLocation? { get }
    
    func requestPermition()
}
