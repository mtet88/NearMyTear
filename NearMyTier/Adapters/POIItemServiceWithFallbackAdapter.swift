//
//  POIItemServiceWithFallbackAdapter.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation

struct POIItemServiceWithFallbackAdapter: POIItemService {

    var primary: POIItemService
    var fallback: POIItemService

    func loadPOIItems(completion: @escaping ([POIItem]) -> Void) {
        
        self.primary.loadPOIItems { (primaryCellItems: [POIItem]) in
            
            guard (primaryCellItems.isEmpty == true) else {
                completion(primaryCellItems)
                return
            }
            
            self.fallback.loadPOIItems { (fallbackCellItems: [POIItem]) in
                completion(fallbackCellItems)
            }
        }
    }
}
