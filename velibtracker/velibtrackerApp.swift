//
//  velibtrackerApp.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import SwiftUI

@main
struct velibtrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init() {
        fetchVelibData()
     }
}
