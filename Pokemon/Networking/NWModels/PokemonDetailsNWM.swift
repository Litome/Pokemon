//
//  PokemonDetailsNWM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

class PokemonDetailsNWM: Codable {
    let front_default: String
    
    init(front_default: String = "") {
        self.front_default = front_default
    }
}
