//
//  VehicleBatteryFilterAdapter.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 14.06.21.
//

import Foundation

struct VehicleBatteryFilterAdapter: POIItemService {

    var vehiclesSource: POIItemService

    func loadPOIItems(completion: @escaping ([POIItem]) -> Void) {
        
        self.vehiclesSource.loadPOIItems { (pois: [POIItem]) in
            
            completion(pois.filter { (poi: POIItem) in
                return ((poi.battery ?? 0) > 0)
            })
        }
    }
}
