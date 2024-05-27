//
//  PokemonsListViewVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation
import SwiftUI

extension PokemonsListView {
    
    @MainActor
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
        
        private func updateLoadingState(_ state: LoadingState) async {
            await MainActor.run { [state] in
                self.loadingState = state
            }
        }
        
        @MainActor
        func getPokemonsFromNW() async {
            await nwPresenter.getDetailedPokemonsListPresenter(self)
        }
        
        @MainActor
        func getPokemonDetailsFromNW(_ pokemon: PokemonVM) async {
            if let detailsURL = pokemon.details {
                do {
                    let details = try await getPokemonDetails(detailsURL)
                    if let spriteStr = details?.front_default {
                        addSprite(spriteStr, toPokemon: pokemon.name)
                    }
                } catch {
                    print("Failed to get pokemon details from NW")
                }
            }
        }
        
        @MainActor
        func getSprite(_ pokemon: PokemonVM) async -> UIImage? {
            if pokemon.sprite == nil {
                await getPokemonDetailsFromNW(pokemon)
            }
            return await pokemon.getSprite()
        }
        
        
        /// PokemonNetworkingProtocol
        
        func startLoading() async {
            await updateLoadingState(.loading)
        }
//        func partiallyLoaded() {
//            updateLoadingState(.partiallyLoaded)
//        }
//        func finishedLoading() {
//            updateLoadingState(.fullyLoaded)
//        }
        func finishedLoading() async {
            await updateLoadingState(.loaded)
        }
        func failedLoading() async {
            await updateLoadingState(.failed)
        }
        
        
        func addPokemon(_ name: String, details: String?, sprite: String? = nil) async {
            var detailsURL: URL?
            if let detailsStr = details {
                detailsURL = URL(string: detailsStr)
            }
            var spriteURL: URL?
            if let spriteStr = sprite {
                spriteURL = URL(string: spriteStr)
            }
            let (_ ,_) = await MainActor.run {
                pokemonsList.insert(PokemonVM(name, details: detailsURL, sprite: spriteURL))
            }
        }
        
        func addSprite(_ sprite: String, toPokemon: String) {
            pokemonsList.first(where: { $0.name == toPokemon })?.sprite = URL(string: sprite)
        }
        
        func getPokemonsList() -> [PokemonVM] {
            return pokemonsList.sorted{ $0.name < $1.name }
        }
    }
}
