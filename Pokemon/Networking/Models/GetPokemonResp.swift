//
//  GetPokemonResp.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

struct GetPokemonResp: Codable {
    
    /// Information related to a pokemon's sprites
    struct Sprites: Codable {
        let front_default: String?
        let back_default: String?
    }
    
    /// Information about the pokemon's species
    struct Species: Codable {
        let name: String
        let url: String
    }
    
    /// Unique ID of a pokemon
    let id: Int
    
    /// Name of a pokemon - also unique
    let name: String
    
    /// Details of the pokemon's sprites
    let sprites: Sprites
    
    /// Details of the pokemon's species
    let species: Species
    
    /// Pokemon's height
    let height: Int
    
    /// Pokemon's weight
    let weight: Int
}
