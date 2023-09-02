//
//  VelibStationStruct.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import Foundation

struct VelibResponse: Codable {
    let totalCount: Int
    let results: [VelibStation]
    private enum CodingKeys: String, CodingKey {
           case totalCount = "total_count"
           case results
       }
}

struct VelibStation: Codable {
    let stationcode: String
    let name: String
    let capacity: Int
    let numdocksavailable: Int
    let numbikesavailable: Int
    let mechanical: Int
    let ebike: Int
    let coordonnees_geo: Coordinates
    
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

let test = [
    VelibStation(stationcode: "293", name: "Test", capacity: 3, numdocksavailable: 3, numbikesavailable: 3, mechanical: 3, ebike: 1, coordonnees_geo: Coordinates(lon: 3.5939, lat: 2.59094)),
    VelibStation(stationcode: "293R", name: "Test2", capacity: 5, numdocksavailable: 3, numbikesavailable: 2, mechanical: 3, ebike: 1, coordonnees_geo: Coordinates(lon: 5.5939, lat: 3.59094))
]

let testAPI2 = VelibResponse(totalCount: 2, results: [
    VelibStation(stationcode: "293", name: "Test", capacity: 3, numdocksavailable: 3, numbikesavailable: 3, mechanical: 3, ebike: 1, coordonnees_geo: Coordinates(lon: 3.5939, lat: 2.59094)),
    VelibStation(stationcode: "293R", name: "Test2", capacity: 5, numdocksavailable: 3, numbikesavailable: 2, mechanical: 3, ebike: 1, coordonnees_geo: Coordinates(lon: 5.5939, lat: 3.59094))
])


func fetchVelibStations(completion: @escaping ([VelibStation]?, Error?) -> Void) {
    guard let url = URL(string: "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/velib-disponibilite-en-temps-reel/records?select=stationcode,name,capacity,numdocksavailable,numbikesavailable,mechanical,ebike,coordonnees_geo") else {
        completion(nil, NSError(domain: "fr.louisgallet.velibtracker", code: 1, userInfo: nil))
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }

        guard let data = data else {
            completion(nil, NSError(domain: "fr.louisgallet.velibtracker", code: 2, userInfo: nil))
            return
        }
        let decoder = JSONDecoder()
        do {
            let velibResponse = try decoder.decode(VelibResponse.self, from: data)
            let stations = velibResponse.results
            // Utilisez la liste des stations dans votre application
        } catch {
            print("Erreur lors du décodage JSON : \(error)")
        }
        print("Fetched + decoded")
    }.resume()
}


