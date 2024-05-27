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
        
        func getSortedPokemonsList() -> [PokemonVM] {
            return pokemonsList.sorted{ $0.name < $1.name }
        }
        
        /// PokemonNetworkingProtocol
        
        func startLoading() async {
            await updateLoadingState(.loading)
        }
        func finishedLoading() async {
            await updateLoadingState(.loaded)
        }
        func failedLoading() async {
            await updateLoadingState(.failed)
        }
        
        func addPokemon(_ name: String, details: String?,
                        spriteFront: String? = nil,
                        spriteBack: String? = nil) async {
            var detailsURL: URL?
            if let detailsStr = details {
                detailsURL = URL(string: detailsStr)
            }
            var spriteFrontURL: URL?
            if let spriteFrontStr = spriteFront {
                spriteFrontURL = URL(string: spriteFrontStr)
            }
            var spriteBackURL: URL?
            if let spriteBackStr = spriteBack {
                spriteBackURL = URL(string: spriteBackStr)
            }
            let (_ ,_) = await MainActor.run {
                pokemonsList.insert(PokemonVM(name,
                                              details: detailsURL,
                                              spriteFront: spriteFrontURL,
                                              spriteBack: spriteBackURL))
            }
        }
    }
}
