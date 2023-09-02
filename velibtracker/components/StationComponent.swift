//
//  StationComponent.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import SwiftUI

import SwiftUI

struct StationComponent: View {
    
    let station: VelibStation

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(station.name)
                .font(.title)
                .foregroundColor(.primary)

            HStack {
                Text("Capacité: \(station.capacity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                Text("Disponibles: \(station.numbikesavailable)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}


struct StationComponent_Previews: PreviewProvider {
    static var previews: some View {
        StationComponent(station: test[1])
    }
}
