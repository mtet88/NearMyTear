//
//  VehiclesAPIAdapter.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation

class VehiclesAPIAdapter: NSObject, POIItemService {

    var vehiclesApi: VehiclesAPI
    var vehiclesCache: VehiclesCache?
    var select: ((Vehicle) -> Void)
    
    init(vehiclesApi: VehiclesAPI, vehiclesCache: VehiclesCache? = nil, select: @escaping ((Vehicle) -> Void)) {
        
        self.vehiclesApi = vehiclesApi
        self.vehiclesCache = vehiclesCache
        self.select = select
    }
    
    func loadPOIItems(completion: @escaping ([POIItem]) -> Void) {
        
        self.vehiclesApi.fetchVehicles { (vehicles: [Vehicle]) in

            self.vehiclesCache?.cache(vehicles: vehicles)

            completion( vehicles.map { (vehicle: Vehicle) in
                
                return POIItem(with: vehicle) {
                    self.select(vehicle)
                }
            })
        }
    }
}

