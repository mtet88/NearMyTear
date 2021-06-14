//
//  VehicleAnnotationView.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import UIKit
import MapKit
import Foundation

class VehicleAnnotationView: MKAnnotationView {
    
    @IBOutlet var clusterCountLable: UILabel?
    @IBOutlet var batteryView: UIProgressView?
    
    func setup(with poiItem: MKAnnotation) {
        
        if let _poiItem = poiItem as? POIItem {
            self.clusterCountLable?.text = " "
            self.batteryView?.isHidden = false
            self.batteryView?.progress = (_poiItem.battery ?? 0)
        } else if let _clusterItem = poiItem as? MKClusterAnnotation {
            self.batteryView?.isHidden = true
            self.clusterCountLable?.text = "\(_clusterItem.memberAnnotations.count)"
        }
    }
    
    static func instanceFromNib() -> VehicleAnnotationView? {
        
        let vehicleAnnotationView = UINib(nibName: "VehicleAnnotationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? VehicleAnnotationView
        
        vehicleAnnotationView?.clusteringIdentifier = String(describing: Self.self)
        return vehicleAnnotationView
    }
}


