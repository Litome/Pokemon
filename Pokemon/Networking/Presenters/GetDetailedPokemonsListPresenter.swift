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
            
            // Sequencially, block by block get the whole Pokemon list from the server
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
                                   print("Get details for pokemon \(pokemon.name)")
                                   let details = try await getPokemonDetails(detailsUrl)
                                   await model.addPokemon(pokemon.name, 
                                                          details: pokemon.url,
                                                          spriteFront: details?.sprites.front_default,
                                                          spriteBack: details?.sprites.back_default)
                               } else {
                                   // If we can't get any details at all, do we still want that pokemon in the view model?
                                   // Ignore for now.
                                   print("Ignore pokemon \(pokemon.name). We can't get details for it with url \(pokemon.url).")
                               }
                            }
                        } catch {
                            print("Failed to get the details of a pokemon from the server \(error)")
                            // But we might succeed for some of the others so carry on.
                        }
                    }
                    
                    print("Added \(list.count) pokemons to model")
                }
                if let next = pokemonsListResp?.next {
                    // Let's get the next few pokemons
                    pokemonsListResp = try await getPokemonsList(next)
                } else {
                    // Finished getting the full list of pokemons
                    pokemonsListResp = nil
                }
            } while pokemonsListResp != nil
            
            print("Finished getting all the pokemons")
            await model.finishedLoading()
            
        } catch {
            print("Failed to get the list of pokemons from the server \(error)")
            await model.failedLoading()
        }
    }
}
