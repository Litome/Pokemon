//
//  GetPokemonsResp.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

struct GetPokemonsResp: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonNWM]
    
    init(count: Int = 0, next: String? = nil, previous: String? = nil, results: [PokemonNWM] = []) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
