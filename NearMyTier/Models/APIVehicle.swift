//
//  APIVehicle.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 22.05.21.
//

import Foundation

struct APIVehicle: Decodable {

    var id: String?
    var vehicleId: String?
    var hardwareId: String?
    var zoneId: String?
    var resolution: String?
    var resolvedBy: String?
    var resolvedAt: String?
    var battery: Int?
    var state: String?
    var model: String?
    var fleetbirdId: Int?
    var latitude: Double?
    var longitude: Double?
}
