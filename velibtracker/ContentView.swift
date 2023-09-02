//
//  ContentView.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
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
