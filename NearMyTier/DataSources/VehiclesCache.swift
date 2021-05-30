//
//  VehiclesCache.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation

class VehiclesCache: NSObject {
    
    private var vehicles = [Vehicle]()
    
    private static var singleton: VehiclesCache?
    public static var shared: VehiclesCache {
        
        if let _singleton = self.singleton {
            return _singleton
        }
        
        let newSingleton = VehiclesCache()
        self.singleton = newSingleton
        return self.shared
    }
    
    func cache(vehicles: [Vehicle]) {
        self.vehicles = vehicles
    }
    
    func loadCachedVehicles(completion: @escaping ([Vehicle]) -> Void) {
        completion(self.vehicles)
    }
}

