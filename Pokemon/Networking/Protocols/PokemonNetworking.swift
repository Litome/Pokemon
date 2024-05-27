//
//  PokemonNetworking.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 24/05/2024.
//

import Foundation

protocol PokemonNetworking {
        
    func startLoading()
//    func partiallyLoaded()
    func finishedLoading()
    func failedLoading()
    
    func addPokemon(_ name: String, details: String?, sprite: String?)
    func addSprite(_ sprite: String, toPokemon: String)
    func getPokemonsList() -> [PokemonVM]
}
