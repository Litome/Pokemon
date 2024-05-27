//
//  GetDetailedPokemonsListPresenter.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation
import CollectionConcurrencyKit

class PokemonsNWPresenter {
    
    func getDetailedPokemonsListPresenter(_ model: PokemonNetworking) async {
        
        do {
            await model.startLoading()
            
            var nwPokemons: [PokemonNWM] = []
            
            var pokemonsListResp = try await getPokemonsList()
            repeat {
                if let list = pokemonsListResp {
                    print("Retrieve \(list.count) pokemons")
                    
                    print("Got \(list.count) pokemons from server.")
                    
                    for pokemon in list.results {
                        // Populate our View Model with partial NW data
                        await model.addPokemon(pokemon.name, details: pokemon.url , sprite: nil)
                    }
                    // Keep the list of results so we can concurrently retrieve some details for all the pokemons in the background.
                    nwPokemons += list.results
                    
                    print("Added \(list.count) pokemons to model")
                }
                if let next = pokemonsListResp?.next {
                    print("Let's get the next few pokemons names")
                    pokemonsListResp = try await getPokemonsList(next)
                } else {
                    print("Finished getting all pokemon's names")
                    pokemonsListResp = nil
                }
            } while pokemonsListResp != nil
            
            // We've got all the names.
//            model.partiallyLoaded()
            let allNwPokemons = nwPokemons
            
            print("Let's get the sprites now")
            Task {
                do {
                    try await allNwPokemons.concurrentForEach { [model] pokemon in
//                        if let detailsStr = pokemon.url,
                       if let detailsUrl = URL(string: pokemon.url) {
                            print("Got a details URL for pokemon \(pokemon.name)")
                            let details = try await getPokemonDetails(detailsUrl)
                            if let spriteStr = details?.front_default {
                                print("Add sprite details to pokemon \(pokemon.name)")
                                await model.addSprite(spriteStr, toPokemon: pokemon.name)
                            }
                        }
                    }
                } catch {
                    print("Failed to get the details of some of the pokemons from the server \(error)")
                    // We might succeed for some of the others...
                }
            }
            print("Finished getting all the pokemons sprites url strings")
            await model.finishedLoading()
            
        } catch {
            print("Failed to get the list of pokemons from the server \(error)")
            await model.failedLoading()
        }
    }
}
