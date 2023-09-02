//
//  ContentView.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()
    @State private var isLocationAuthorized = false
    var body: some View {
        VStack {
            var latitude = locationManager.userLocation?.latitude
            var longitude = locationManager.userLocation?.longitude
            if locationManager.isLocationAuthorized {
                // Afficher le contenu de l'application une fois que la localisation est autorisée
                Text("Latitude: \(locationManager.userLocation?.latitude ?? 0), Longitude: \(locationManager.userLocation?.longitude ?? 0)")
            } else {
                // Afficher un message ou un bouton pour demander l'autorisation de localisation
                Button("Autoriser la localisation") {
                    locationManager.onLocationUpdate = {
                        // Appel à la requête API lorsque la localisation est autorisée
                    }
                }
            }
        }
        .onAppear {
            if locationManager.isLocationAuthorized {
                // Appel à la requête API lorsque la localisation est déjà autorisée
                fetchVelibDataLocation(lon: Double(locationManager.userLocation?.longitude ?? 0), lat: Double(locationManager.userLocation?.latitude ?? 0))
                print("State updated")
            }
        }
        NavigationView {
            ScrollView {
                ForEach(velibStations, id: \.stationcode) { station in
                    StationComponent(station: station)
                        .padding(.bottom, 16)
                }
            }
            .navigationBarTitle("Stations Vélib")
        }
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
