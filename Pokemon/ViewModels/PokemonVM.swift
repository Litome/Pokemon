//
//  PokemonVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

struct PokemonVM: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    
    init(_ name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
