//
//  getPokemonsList.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

func getPokemonsList(_ next: String? = nil) async throws -> GetPokemonsResp? {
    
    if let url = URL(string: next ?? endpoint + "pokemon") {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let list = try JSONDecoder().decode(GetPokemonsResp.self, from: data)
            return list
            
        } catch let jsonError {
            print("getPokemonsList - Failed to decode json", jsonError)
        }
    }
    return nil
}
