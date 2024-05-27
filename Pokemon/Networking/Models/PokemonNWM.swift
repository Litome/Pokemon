//
//  PokemonNWM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

class PokemonNWM: Codable, Hashable {
    
    /// Pokemon's name - unique
    let name: String
    
    /// Where to get the detailed info for this pokemon
    let url: String
    
    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
    
    /// Codable protocol
    static func == (lhs: PokemonNWM, rhs: PokemonNWM) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    /// Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
