//
//  PokemonsListVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 22/05/2024.
//

import Foundation

extension PokemonsListView {

    struct PokemonVM: Codable, Identifiable, Hashable {
        let id: String
        let name: String
        
        init(_ name: String) {
            self.id = UUID().uuidString
            self.name = name
        }
    }
    
    @Observable
    class ViewModel: PokemonNetworking {
        
        private(set) var loadingState = LoadingState.loading
        private(set) var pokemonsList = [PokemonsListView.PokemonVM]()
        
        func updateLoadingState(_ state: LoadingState) {
            self.loadingState = state
        }
        
        func addPokemon(_ name: String, sprite: String?) {
            pokemonsList.append(PokemonVM(name))
        }
    }
}
