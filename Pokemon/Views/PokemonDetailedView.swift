//
//  PokemonDetailedView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 27/05/2024.
//

import SwiftUI

struct PokemonDetailedView: View {
    @ObservedObject var pokemon: PokemonVM
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    if let sprite = pokemon.sprite {
                        AsyncImage(url: sprite) { phase in
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
                            @unknown default:
                                ProgressView()
                            }
                        }
                        .scaledToFit()
                        .frame(width: 80.0, height: 80.0, alignment: .center)
                    } else {
                        Image(systemName: spritePlaceholder)
                            .scaledToFit()
                            .frame(width: 80.0, height: 80.0, alignment: .center)
                    }
                }
                Text(pokemon.name)
                    .font(.title)
                    .tint(.accentColor)
            }
            //                        Label(pokemon.name, systemImage: spritePlaceholder)
            //                            .font(.largeTitle).bold()
        }
    }
}

struct PokemonDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailedView(pokemon: PokemonVM.samples[0])
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
    }
}
