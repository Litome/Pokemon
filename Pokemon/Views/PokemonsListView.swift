//
//  PokemonsListView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

//import SwiftData
import SwiftUI

let spritePlaceholder = "fossil.shell.fill"
let loadingIcon = "hourglass"
let issueIcon = "exclamationmark.triangle"

//struct Pokemon: Identifiable, Hashable {
//    var id = UUID()
//    var name: String
//    var sprite: String
//}
//
//extension Pokemon {
//    static let samples = [
//        Pokemon(name: "bulbasaur", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
//        Pokemon(name: "pigeotto", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png"),
//        Pokemon(name: "ivysaur", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"),
//        Pokemon(name: "zorua-hisui", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1022.png")
//    ]
//}
//
//private class PokemonsViewModel: ObservableObject {
//    @Published var pokemons: [Pokemon] = Pokemon.samples
//}

struct PokemonsListView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    
    //    @StateObject fileprivate var pokemonsModel = PokemonsViewModel()
    @State private var searchName = ""
    
    var body: some View {
        
        NavigationStack {
            switch viewModel.loadingState {
            case .loaded:
                List {
                    ForEach(searchResults, id: \.self) { pokemon in
                        NavigationLink(value: pokemon) {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                }
                .searchable(text: $searchName)
                .navigationTitle("Pokémons")
                .navigationDestination(for: PokemonVM.self) { pokemon in
                    ZStack {
                        Label(pokemon.name, systemImage: spritePlaceholder)
                            .font(.largeTitle).bold()
                    }
                }
            case .loading:
                Label("Loading...", systemImage: loadingIcon)
            case .failed:
                Label("Failed to load Pokemons. Please try again later.",
                      systemImage: issueIcon)
            }
        }
        .task {
            await viewModel.getPokemonsFromNW()
        }
    }
    
    var searchResults: [PokemonVM] {
        if searchName.isEmpty {
            return viewModel.getPokemonsList()
        } else {
            return viewModel.getPokemonsList().filter { $0.name.localizedCaseInsensitiveContains(searchName) }
        }
    }
}

#Preview {
    PokemonsListView()
}
