//
//  velibtrackerApp.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import SwiftUI


@main
struct velibtrackerApp: App {
    @ObservedObject var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
     init() {
         fetchVelibDataLocation(lon: Double(locationManager.userLocation?.longitude ?? 0), lat: Double(locationManager.userLocation?.latitude ?? 0))
      }
}
