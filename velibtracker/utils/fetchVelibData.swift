//
//  fetchVelibData.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import Foundation


var velibStations: [VelibStation] = []

func fetchVelibData() {
    // L'URL de l'API Vélib
    let apiUrl = URL(string: "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/velib-disponibilite-en-temps-reel/records?select=stationcode,name,capacity,numdocksavailable,numbikesavailable,mechanical,ebike,coordonnees_geo")!

    // Créez une session URLSession pour effectuer la requête
    let session = URLSession.shared

    // Créez la tâche de requête
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Vérifiez s'il y a des erreurs
        if let error = error {
            print("Query error : \(error.localizedDescription)")
            return
        }

        // Vérifiez si les données sont présentes
        guard let data = data else {
            print("No data received.")
            return
        }

        do {
            // Décodez les données en utilisant le décodeur JSON
            let decoder = JSONDecoder()
            let velibResponse = try decoder.decode(VelibResponse.self, from: data)

            // Stockez les données dans la variable globale velibStations
            velibStations = velibResponse.results

            print("Vélib data successfully recovered.")
        } catch {
            print("Error decoding JSON : \(error.localizedDescription)")
        }
    }

    // Lancez la tâche de requête
    task.resume()
}


func fetchVelibDataLocation(lon: Double, lat: Double) {
    // L'URL de l'API Vélib
    print(lon, lat)
    let urlString = URL(string: "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/velib-disponibilite-en-temps-reel/records?select=stationcode,name,capacity,numdocksavailable,numbikesavailable,mechanical,ebike,coordonnees_geo&where=distance(coordonnees_geo,geom%27POINT(\(lon)\("%20")\(lat))%27,5km)")!

    // Créez une session URLSession pour effectuer la requête
    let session = URLSession.shared

    // Créez la tâche de requête
    let task = session.dataTask(with: urlString) { (data, response, error) in
        // Vérifiez s'il y a des erreurs
        if let error = error {
            print("Query error : \(error.localizedDescription)")
            return
        }

        // Vérifiez si les données sont présentes
        guard let data = data else {
            print("No data received.")
            return
        }

        do {
            // Décodez les données en utilisant le décodeur JSON
            let decoder = JSONDecoder()
            let velibResponse = try decoder.decode(VelibResponse.self, from: data)

            // Stockez les données dans la variable globale velibStations
            velibStations = velibResponse.results
            print(velibStations)

            print("Vélib data successfully recovered.")
        } catch {
            print("Error decoding JSON : \(error.localizedDescription)")
        }
    }

    // Lancez la tâche de requête
    task.resume()
}
