//
//  PokemonRowView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 27/05/2024.
//

import SwiftUI

struct PokemonRowView: View {
    @ObservedObject var pokemon: PokemonVM
    
    let squareIconSide = 40.0
    
    var listIcon: some View {
        ZStack {
            if let sprite = pokemon.spriteFrontUrl {
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
                .frame(width: squareIconSide, height: squareIconSide, alignment: .center)
            } else {
                Image(systemName: spritePlaceholder)
                .scaledToFit()
                .frame(width: squareIconSide, height: squareIconSide, alignment: .center)
            }
        }
    }
    
    var body: some View {
        LazyHStack {
            listIcon
            Text(pokemon.name)
            Spacer()
        }
    }
}

struct PokemonRowView_Previews: PreviewProvider {
    static var previews: some View {
//        Group {
            PokemonRowView(pokemon: PokemonVM.samples[0])
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
//            PokemonRowView(pokemon: Pokemon.samples[0])
//                .preferredColorScheme(.dark)
//                .previewLayout(.sizeThatFits)
//        }
    }
}
