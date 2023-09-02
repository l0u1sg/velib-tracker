//
//  LocationManager.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import Foundation

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var isLocationAuthorized = false
    var onLocationUpdate: (() -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location.coordinate
            isLocationAuthorized = true
            onLocationUpdate?() // Appelé lorsque la localisation est mise à jour
        }
    }
}
