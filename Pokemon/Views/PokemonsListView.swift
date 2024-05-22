//
//  PokemonsListView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import SwiftUI

struct PokemonsListView: View {

    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            List {
                switch viewModel.loadingState {
                case .loaded:
                    ForEach(viewModel.pokemonsList, id: \.id) { pokemon in
                        NavigationLink(value: pokemon) {
                            Label(pokemon.name, systemImage: "fossil.shell.fill")
                                .foregroundColor(.primary)
                        }
                    }
                case .loading:
                    Label("Loading...", systemImage: "hourglass")
                case .failed:
                    Label("Failed to load Pokemons. Please try again later.", systemImage: "exclamationmark.triangle")
                }
            }
            .navigationTitle("Pokémons")
            .navigationDestination(for: PokemonVM.self) { pokemon in
                ZStack {
                    Label(pokemon.name, systemImage: "fossil.shell.fill")
                        .font(.largeTitle).bold()
                }
            }
            .task {
                await getPokemonsList(viewModel)
            }
        }
    }
}

#Preview {
    PokemonsListView()
}
