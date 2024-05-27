//
//  PokemonNetworking.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 24/05/2024.
//

import Foundation

protocol PokemonNetworking {
        
    func startLoading() async
//    func partiallyLoaded()
    func finishedLoading() async
    func failedLoading() async
    
    func addPokemon(_ name: String, details: String?, sprite: String?) async
    func addSprite(_ sprite: String, toPokemon: String) async
//    func getPokemonsList() -> [PokemonVM]
}
