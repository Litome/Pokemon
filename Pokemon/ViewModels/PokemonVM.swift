//
//  PokemonVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 24/05/2024.
//

import Foundation
import SwiftUI

extension PokemonVM {
    static let samples = [
        PokemonVM("bulbasaur",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/1/"),
                  spriteFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
                  spriteBack: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png")), //,
//                  speciesName: "Humanoid",
//                  height: 100,
//                  weight: 3000),
        PokemonVM("pigeotto",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/17/"),
                  spriteFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png"),
                  spriteBack: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/17.png")), //,
//                  speciesName: "Avian",
//                  height: 30,
//                  weight: 10),
        PokemonVM("ivysaur",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/2/"),
                  spriteFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"),
                  spriteBack: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png")), //,
//                  speciesName: "Reptile",
//                  height: 60,
//                  weight: 40),
        PokemonVM("zorua-hisui",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/1022/"),
                  spriteFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1022.png"),
                  spriteBack: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1022.png")) //,
//                  speciesName: "Fish",
//                  height: 50,
//                  weight: 50)
    ]
}

@MainActor
class PokemonVM: Identifiable, Hashable, Comparable, ObservableObject {
    
    let id: UUID
    let name: String
    let detailsUrl: URL?
    let spriteFrontUrl: URL?
    let spriteBackUrl: URL?
//    let speciesName: String
//    let height: Int
//    let weight: Int
    
    init(_ name: String, 
         details: URL? = nil,
         spriteFront: URL? = nil,
         spriteBack: URL? = nil,
         speciesName: String = "",
         height: Int = 0,
         weight: Int = 0) {
        self.id = UUID()
        self.name = name
        self.detailsUrl = details
        self.spriteFrontUrl = spriteFront
        self.spriteBackUrl = spriteBack
//        self.speciesName = speciesName
//        self.height = height
//        self.weight = weight
    }
    
    nonisolated static func == (lhs: PokemonVM, rhs: PokemonVM) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    nonisolated static func < (lhs: PokemonVM, rhs: PokemonVM) -> Bool {
        return lhs.name < rhs.name ? true : false
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

