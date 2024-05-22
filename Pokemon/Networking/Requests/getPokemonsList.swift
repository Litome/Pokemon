//
//  getPokemonsList.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

func getPokemonsList(_ model: PokemonNetworking) async {
    if let url = URL(string: endpoint + "pokemon") {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                model.updateLoadingState(.failed)
                return
            }
            
            guard let data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(GetPokemonsResp.self, from: data)
                for pokemon in decodedData.results {
                    // Populate our View Model from the NW data
                    model.addPokemon(pokemon.name, sprite: nil)
                }
                model.updateLoadingState(.loaded)
            } catch let jsonError {
                print("Failed to decode json", jsonError)
                model.updateLoadingState(.failed)
            }
        }
        
        task.resume()
    }
}

