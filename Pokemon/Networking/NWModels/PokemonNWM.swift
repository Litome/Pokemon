//
//  PokemonNWM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

struct PokemonNWM: Codable {
    let name: String
    let url: String
    
    init(name: String = "", url: String = "") {
        self.name = name
        self.url = url
    }
}
