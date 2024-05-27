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
                  sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")),
        PokemonVM("pigeotto",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/17/"),
                  sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png")),
        PokemonVM("ivysaur",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/2/"),
                  sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png")),
        PokemonVM("zorua-hisui",
                  details: URL(string: "https://pokeapi.co/api/v2/pokemon/1022/"),
                  sprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1022.png"))
    ]
}

@MainActor
class PokemonVM: Identifiable, Hashable, Comparable, ObservableObject {
    
    let id: UUID
    let name: String
    @Published var details: URL?
    @Published var sprite: URL?
    
    var isFullyLoaded: Bool {
        if sprite != nil {
            return true
        }
        return false
    }
    
    init(_ name: String, details: URL? = nil, sprite: URL? = nil) {
        self.id = UUID()
        self.name = name
        self.details = details
        self.sprite = sprite
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
    
    @MainActor
    func getSprite() async -> UIImage {
        let placeholder = UIImage(systemName: "fossil.shell.fill")!
        if let spriteURL = self.sprite {
            do {
//                let data = try Data(contentsOf: url)
//                let image = UIImage(data: data)
//                return image
                
                let request = URLRequest(url: spriteURL)
                let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
                print("Finished loading image")
                return UIImage(data: data) ?? placeholder
            } catch {
                return placeholder
            }
        }
        return placeholder
    }
}

