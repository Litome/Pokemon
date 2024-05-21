//
//  ContentView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 21/05/2024.
//

import SwiftUI

var pokemons: [PokemonVM] = [
    .init("Poke1"),
    .init("Poke2"),
    .init("Poke3"),
    .init("Poke4")]

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(pokemons, id: \.id) { pokemon in
                    NavigationLink(value: pokemon) {
                        Label(pokemon.name, systemImage: "person.fill")
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Pokémons")
            .navigationDestination(for: PokemonVM.self) { pokemon in
                ZStack {
                    Label(pokemon.name, systemImage: "person.fill")
                        .font(.largeTitle).bold()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
