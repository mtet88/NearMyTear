//
//  POIItem.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import MapKit
import Foundation

class POIItem: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var battery: Float?
    var coordinate: CLLocationCoordinate2D
    
    var selection: (() -> Void)?
    
    init(title: String?, subtitle: String?, battery: Float?, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.subtitle = subtitle
        self.battery = battery
        self.coordinate = coordinate
    }
}

extension POIItem {

    convenience init(with vehicle: Vehicle, selection block: @escaping (() -> Void)) {
        
        self.init(title: vehicle.model, subtitle: "🔋 \(vehicle.battery)%", battery: Float(vehicle.battery)/100, coordinate: vehicle.location)

        self.selection = block
    }
}
