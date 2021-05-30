//
//  POIItemService.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import Foundation

protocol POIItemService {
    
    func loadPOIItems(completion: @escaping ([POIItem]) -> Void)
}

extension POIItemService {
    
    func fallback(_ fallbackService: POIItemService) -> POIItemService {
        return POIItemServiceWithFallbackAdapter(primary: self, fallback: fallbackService)
    }
    
    func retry(_ times: UInt = 1) -> POIItemService {
        
        guard (times > 0) else {
            return self
        }
        
        return self.fallback(self.retry(times - 1))
    }
}

