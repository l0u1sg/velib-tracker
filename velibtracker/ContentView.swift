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
            if locationManager.isLocationAuthorized {
                // Afficher le contenu de l'application une fois que la localisation est autorisée
            } else {
                // Afficher un message ou un bouton pour demander l'autorisation de localisation
                Button("Autoriser la localisation") {
                    openAppSettings()
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
                Text("Stations dans un rayon de 5km")
                ForEach(velibStations, id: \.stationcode) { station in
                    StationComponent(station: station)
                        .padding(.bottom, 16)
                }
            }
            .navigationBarTitle("Stations Vélib")
        }
        
    }
    
}

private func openAppSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    
    if UIApplication.shared.canOpenURL(settingsURL) {
        UIApplication.shared.open(settingsURL)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
