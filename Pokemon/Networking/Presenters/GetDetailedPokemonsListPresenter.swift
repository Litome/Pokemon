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
            model.startLoading()
                        
            var pokemonsList = try await getPokemonsList() 
            repeat {
                if let list = pokemonsList {
                    print("Retrieve \(list.count) pokemons")
                    
                    print("Got \(list.count) pokemons from server.")
                    
                    for pokemon in list.results {
                        // Populate our View Model with partial NW data
                        model.addPokemon(pokemon.name, details: pokemon.url , sprite: nil)
                    }
                    print("Added \(list.count) pokemons to model")
                }
                if let next = pokemonsList?.next {
                    print("Let's get the next few pokemons names")
                    pokemonsList = try await getPokemonsList(next)
                } else {
                    print("Finished getting all pokemon's names")
                    pokemonsList = nil
                }
            } while pokemonsList != nil
            
            // We've got all the names.
//            model.partiallyLoaded()
            
            print("Let's get the sprites now")
            Task {
                do {
                    let pokemons = model.getPokemonsList()
                    try await pokemons.concurrentForEach { [model] pokemon in
                        if let detailsString = pokemon.detailsURL {
                            print("Got a details URL for pokemon \(pokemon.name)")
                            let details = try await getPokemonDetails(detailsString)
                            if let spriteString = details?.front_default {
                                print("Add sprite details to pokemon \(pokemon.name)")
                                model.addSprite(spriteString, toPokemon: pokemon.name)
                            }
                        }
                    }
                } catch {
                    print("Failed to get the details of some of the pokemons from the server \(error)")
                    // We might succeed for some of the others...
                }
            }
            print("Finished getting all the pokemons sprites url strings")
            model.finishedLoading()
            
        } catch {
            print("Failed to get the list of pokemons from the server \(error)")
            model.failedLoading()
        }        
    }
}
