//
//  GetPokemonResp.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

struct GetPokemonResp: Codable {
    let front_default: String?
    
    init(front_default: String? = nil) {
        self.front_default = front_default
    }
}
