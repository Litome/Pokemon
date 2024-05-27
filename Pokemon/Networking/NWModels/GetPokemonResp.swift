//
//  GetPokemonResp.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

struct GetPokemonResp: Codable {
    struct Sprites: Codable {
        let front_default: String
        let back_default: String
    }
    struct Species: Codable {
        let name: String
        let url: String
    }
    let id: Int
    let name: String
    let sprites: Sprites
    let species: Species
    let height: Int
    let weight: Int
    
//    init(id: Int, name:String, front_default: String = "", height: Int = 0, weight: Int = 0) {
//        self.id = id
//        self.name = name
//        self.front_default = front_default
//        self.height = height
//        self.weight = weight
//    }
}
