//
//  PokemonsListViewVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation
import SwiftUI

extension PokemonsListView {
    
    class ViewModel: PokemonNetworking, ObservableObject {
        
        enum LoadingState: Codable {
            case loading, loaded, failed
//            case loading, partiallyLoaded, fullyLoaded, failed
        }
        
        @Published private(set) var loadingState: LoadingState
        @Published private(set) var pokemonsList: Set<PokemonVM>
        
        private let nwPresenter = PokemonsNWPresenter()
        
        init(loadingState: LoadingState = .loading, pokemonsList: Set<PokemonVM> = []) {
            self.loadingState = loadingState
            self.pokemonsList = pokemonsList
        }
        
        private func updateLoadingState(_ state: LoadingState) {
            self.loadingState = state
        }
        
        func getPokemonsFromNW() async {
            await nwPresenter.getDetailedPokemonsListPresenter(self)
        }
        
        func getPokemonDetailsFromNW(_ pokemon: PokemonVM) async {
            if let detailsString = pokemon.detailsURL {
                do {
                    let details = try await getPokemonDetails(detailsString)
                    if let spriteString = details?.front_default {
                        addSprite(spriteString, toPokemon: pokemon.name)
                    }
                } catch {
                    print("Failed to get pokemon details from NW")
                }
            }
        }
        
        func getSprite(_ pokemon: PokemonVM) async -> UIImage? {
            await getPokemonDetailsFromNW(pokemon)
            return await pokemon.getSprite()
        }
        
        
        /// PokemonNetworkingProtocol
        
        func startLoading() {
            updateLoadingState(.loading)
        }
//        func partiallyLoaded() {
//            updateLoadingState(.partiallyLoaded)
//        }
//        func finishedLoading() {
//            updateLoadingState(.fullyLoaded)
//        }
        func finishedLoading() {
            updateLoadingState(.loaded)
        }
        func failedLoading() {
            updateLoadingState(.failed)
        }
        
        func addPokemon(_ name: String, details: String?, sprite: String? = nil) {
            pokemonsList.insert(PokemonVM(name, details: details, sprite: sprite))
        }
        
        func addSprite(_ sprite: String, toPokemon: String) {
            pokemonsList.first(where: { $0.name == toPokemon })?.spriteURL = sprite
        }
        
        func getPokemonsList() -> [PokemonVM] {
            return pokemonsList.sorted{ $0.name < $1.name }
        }
    }
}
