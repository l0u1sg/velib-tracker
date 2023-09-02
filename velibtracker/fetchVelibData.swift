//
//  fetchVelibData.swift
//  velibtracker
//
//  Created by Louis Gallet on 02/09/2023.
//

import Foundation


var velibStations: [VelibStation] = []

import Foundation

func fetchVelibData() {
    // L'URL de l'API Vélib
    let apiUrl = URL(string: "https://opendata.paris.fr/api/explore/v2.1/catalog/datasets/velib-disponibilite-en-temps-reel/records?select=stationcode,name,capacity,numdocksavailable,numbikesavailable,mechanical,ebike,coordonnees_geo")!

    // Créez une session URLSession pour effectuer la requête
    let session = URLSession.shared

    // Créez la tâche de requête
    let task = session.dataTask(with: apiUrl) { (data, response, error) in
        // Vérifiez s'il y a des erreurs
        if let error = error {
            print("Erreur de requête : \(error.localizedDescription)")
            return
        }

        // Vérifiez si les données sont présentes
        guard let data = data else {
            print("Aucune donnée reçue.")
            return
        }

        do {
            // Décodez les données en utilisant le décodeur JSON
            let decoder = JSONDecoder()
            let velibResponse = try decoder.decode(VelibResponse.self, from: data)

            // Stockez les données dans la variable globale velibStations
            velibStations = velibResponse.results

            print("Données Vélib récupérées avec succès.")
        } catch {
            print("Erreur lors du décodage JSON : \(error.localizedDescription)")
        }
    }

    // Lancez la tâche de requête
    task.resume()
}
