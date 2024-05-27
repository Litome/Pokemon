//
//  GetPokemonsResp.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

struct GetPokemonsResp: Codable {
    
    /// How many pokemons are in the results
    let count: Int
    
    /// Where to get the previous pokemons
    let previous: String?
    
    /// Where to get the next pokemons
    let next: String?
    
    /// List of pokemons names and where to get detailed info for each
    let results: [PokemonNWM]
    
    init(count: Int = 0, next: String? = nil, previous: String? = nil, results: [PokemonNWM] = []) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
