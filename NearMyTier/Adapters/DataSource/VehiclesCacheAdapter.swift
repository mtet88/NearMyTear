//
//  VehiclesCacheAdapter.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation

struct VehiclesCacheAdapter: POIItemService {

    var vehiclesCache: VehiclesCache
    var select: ((Vehicle) -> Void)

    func loadPOIItems(completion: @escaping ([POIItem]) -> Void) {
        
        self.vehiclesCache.loadCachedVehicles { (vehicles: [Vehicle]) in

            completion( vehicles.map { (vehicle: Vehicle) in
                
                return POIItem(with: vehicle) {
                    self.select(vehicle)
                }
            })
        }
    }
}

