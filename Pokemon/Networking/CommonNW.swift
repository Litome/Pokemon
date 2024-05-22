//
//  CommonNW.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import Foundation

let endpoint = "https://pokeapi.co/api/v2/"

enum LoadingState {
    case loading, loaded, failed
}

protocol PokemonNetworking {
    func updateLoadingState(_ state: LoadingState)
    func addPokemon(_ name: String, sprite: String?)
}
