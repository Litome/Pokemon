//
//  getPokemonDetails.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

func getPokemonDetails(_ urlString: String) async throws -> GetPokemonResp? {
    if let url = URL(string: urlString) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
            
        do {
            let pokemonDetailsResp = try JSONDecoder().decode(GetPokemonResp.self, from: data)
            return pokemonDetailsResp
        } catch let jsonError {
            print("Failed to decode json", jsonError)
        }
    }
    return nil
}
