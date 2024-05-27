//
//  PokemonNetworking.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 24/05/2024.
//

import Foundation

protocol PokemonNetworking {
        
    /// We have started requesting pokemons info from the server
    func startLoading() async
    
    /// We have successfully finished requesting pokemons info from the server
    func finishedLoading() async
    
    /// We failed to get the pokemons info from the server
    func failedLoading() async
    
    /// We have the info from the server for a given pokemon - add it to the View model
    func addPokemon(_ name: String, details: String?,
                    spriteFront: String?,
                    spriteBack: String?) async
}
