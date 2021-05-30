//
//  Vehicle.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation
import CoreLocation

struct Vehicle {

    var id: String
    var vehicleId: String?
    var hardwareId: String?
    var zoneId: String?
    var resolution: String?
    var resolvedBy: String?
    var resolvedAt: String?
    var battery: Int
    var state: String?
    var model: String?
    var fleetbirdId: Int?
    var location: CLLocationCoordinate2D
}

extension Vehicle {
    
    init?(with apiVehicle: APIVehicle) {
        
        guard
            let _id = apiVehicle.id,
            let _battery = apiVehicle.battery,
            let _latitude = apiVehicle.latitude,
            let _longitude = apiVehicle.longitude else {
                return nil
        }
        
        self.id = _id
        self.vehicleId = apiVehicle.vehicleId
        self.hardwareId = apiVehicle.hardwareId
        self.zoneId = apiVehicle.zoneId
        self.resolution = apiVehicle.resolution
        self.resolvedBy = apiVehicle.resolvedBy
        self.resolvedAt = apiVehicle.resolvedAt
        self.battery = _battery
        self.state = apiVehicle.state
        self.model = apiVehicle.model
        self.fleetbirdId = apiVehicle.fleetbirdId
        self.location = CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude)
    }
}
