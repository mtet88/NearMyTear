//
//  MapViewController.swift
//  NearMyTier
//
//  Created by Mauricio Torres Mejia on 30.05.21.
//

import UIKit
import MapKit
import Foundation

class MapViewController: NMTViewController {
    
    @IBOutlet var mapView: MKMapView?
    @IBOutlet var filtersSegmentedControl: UISegmentedControl?
    
    var locationService : LocationManagerAdapter?
    
    private var poiItems = [POIItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.reloadService()
    }
    
    private func reloadService() {
        
        let apiService = VehiclesAPIAdapter(vehiclesApi: VehiclesAPI(), vehiclesCache: VehiclesCache.shared) { (vehicle: Vehicle) in
            // Map item selected
        }
        
        let cacheService = VehiclesCacheAdapter(vehiclesCache: VehiclesCache.shared) { (vehicle: Vehicle) in
            // Map item selected
        }

        // Check cache, if nothing found, try api and retry if needed
        cacheService
            .fallback(apiService)
            .retry()
            .filteredByBattery(self.filtersSegmentedControl?.selectedSegmentIndex == 0)
            .loadPOIItems { (items: [POIItem]) in
                
                self.mapView?.removeAnnotations(self.poiItems)
                self.poiItems = items
                self.mapView?.addAnnotations(items)
        }
    }
    
    private func setupViews() {
        self.mapView?.delegate = self
    }
    
    private func filterChanged() {
        
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard (mapView.userLocation.isEqual(annotation) == false) else {
            return nil
        }

        let mkAnnotationView = VehicleAnnotationView.instanceFromNib()
        mkAnnotationView?.setup(with: annotation)
        return mkAnnotationView
    }
}

// MARK: - Actions

extension MapViewController {
    
    @IBAction func filterChanged(_ sender: Any) {
        self.reloadService()
    }
}
