//
//  PokemonNWM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

class PokemonNWM: Codable, Hashable {
    
    let name: String // also unique identifier of a Pokemon
    let url: String // Where to find details about this pokemon
    
    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
    
    static func == (lhs: PokemonNWM, rhs: PokemonNWM) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
