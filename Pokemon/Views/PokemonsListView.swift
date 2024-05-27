//
//  PokemonsListView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

//import SwiftData
import SwiftUI

struct PokemonsListView: View {
    
    @ObservedObject private var viewModel = ViewModel()
    @State private var searchText = ""
    
    let spritePlaceholder = "fossil.shell.fill"
    let loadingIcon = "hourglass"
    let issueIcon = "exclamationmark.triangle"

    var body: some View {
        NavigationStack {
            switch viewModel.loadingState {
//                case .partiallyLoaded:
//                    List(viewModel.getPokemonsList(), id: \.id) { pokemon in
//                        NavigationLink(value: pokemon) {
//                            Label(pokemon.name, systemImage: loadingIcon)
//                        }
//                    }
//                    .listStyle(.sidebar)
//                    .searchable(text: $searchText)
//                case .fullyLoaded:
                case .loaded:
                    List(viewModel.getPokemonsList(), id: \.id) { pokemon in
                        NavigationLink(value: pokemon) {
                            LazyHStack {
                                AsyncImage(url: URL(string: pokemon.spriteURL ?? "")) { phase in
                                    switch phase {
                                    case .failure:
                                        Image(systemName: issueIcon)
                                            .resizable()
                                    case .empty:
                                        Image(systemName: spritePlaceholder)
                                            .resizable()
                                    case .success(let image):
                                        image
                                            .resizable()
//                                    default:
//                                        ProgressView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .scaledToFit()
                                .frame(width: 20.0, height: 20.0, alignment: .center)
//                                if let spriteURL = pokemon.spriteURL {
//                                    AsyncImage(url: URL(string: spriteURL)) { image in
//                                        image.resizable()
//                                    } placeholder : {
//                                        ProgressView()
//                                    }
//                                    .scaledToFit()
//                                    .frame(width: 20.0, height: 20.0, alignment: .center)
//                                } else {
//                                    Image(systemName: spritePlaceholder)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(width: 20.0, height: 20.0, alignment: .center)
//                                }

                                Text(pokemon.name)
                                
                                Spacer()
                            }
                        }
//                        .task {
//                            await viewModel.getPokemonDetailsFromNW(pokemon)
//                        }
                    }
                    .listStyle(.sidebar)
                    .searchable(text: $searchText)
//                    .task {
//                        await viewModel.getPokemonDetailsFromNW(pokemon)
////                                let _ = await viewModel.getSprite(pokemon)
//                    }
                case .loading:
                    Label("Loading...", systemImage: loadingIcon)
                case .failed:
                    Label("Failed to load Pokemons. Please try again later.", 
                          systemImage: issueIcon)
                }
            }
            .navigationTitle("Pokémons")
            .navigationDestination(for: PokemonVM.self) { pokemon in
                ZStack {
                    Label(pokemon.name, systemImage: spritePlaceholder)
                        .font(.largeTitle).bold()
                }
            }
            .task {
                await viewModel.getPokemonsFromNW()
            }
        }
//    }
}

#Preview {
    PokemonsListView()
}
