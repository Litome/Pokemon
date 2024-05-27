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
            
            // Sequencially and block by block get the whole Pokemon list from the server
            // This is ordered by id, not names so we need to get all of them.
            var pokemonsListResp = try await getPokemonsList()
            repeat {
                if let list = pokemonsListResp {
                    print("Got \(list.count) pokemons from server.")

                    // Concurrently get the detailed info for each pokemon in this block of data
                    Task {
                        do {
                            try await list.results.concurrentForEach { [model] pokemon in
                               if let detailsUrl = URL(string: pokemon.url) {
                                   print("Got a details URL for pokemon \(pokemon.name)")
                                   let details = try await getPokemonDetails(detailsUrl)
                                   await model.addPokemon(pokemon.name, 
                                                          details: pokemon.url,
                                                          spriteFront: details?.sprites.front_default,
                                                          spriteBack: details?.sprites.back_default)
                               } else {
                                   // If we can't get any details, do we still want that pokemon in the view model?
                                   // Ignore for now.
                                   print("Ignore pokemon \(pokemon.name) as we can't get details for it with url \(pokemon.url).")
//                                   await model.addPokemon(pokemon.name,
//                                                          details: nil,
//                                                          spriteFront: nil,
//                                                          spriteBack: nil)
                               }
                            }
                        } catch {
                            print("Failed to get the details of a pokemon from the server \(error)")
                            // We might succeed for some of the others...
                        }
                    }
                    
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
            
            print("Finished getting all the pokemons sprites url strings")
            await model.finishedLoading()
            
        } catch {
            print("Failed to get the list of pokemons from the server \(error)")
            await model.failedLoading()
        }
    }
}
