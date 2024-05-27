//
//  PokemonDetailedView.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 27/05/2024.
//

import SwiftUI

struct PokemonDetailedView: View {
    @ObservedObject var pokemon: PokemonVM

    let squareImgSide = 180.0
    let titleEdgeInsets = 20.0
    
    var body: some View {
        ZStack {
            VStack {
                Text(pokemon.name)
                    .font(.title)
                    .tint(.accentColor)
                    .padding(titleEdgeInsets)
                HStack {
                    Spacer()
                    PokemonImgView(spriteUrl: pokemon.spriteFrontUrl, subtitle: "Front")
                        .scaledToFill()
                        .frame(width: squareImgSide, height: squareImgSide, alignment: .center)
                    if let url = pokemon.spriteBackUrl {
                        Spacer()
                        PokemonImgView(spriteUrl: url, subtitle: "Back")
                            .scaledToFill()
                            .frame(width: squareImgSide, height: squareImgSide, alignment: .center)
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct PokemonImgView: View {
    
    var spriteUrl: URL?
    var subtitle: String
    
    var body: some View {
        VStack {
            Spacer()
            if let sprite = spriteUrl {
                AsyncImage(url: sprite) { phase in
                    switch phase {
                    case .failure:
                        Image(systemName: issueIcon)
//                            .resizable()
                    case .empty:
                        Image(systemName: spritePlaceholder)
//                            .resizable()
                    case .success(let image):
                        image
                            .resizable()
                    @unknown default:
                        ProgressView()
                    }
                }
            } else {
                Image(systemName: spritePlaceholder)
//                    .resizable()
            }
            Text(subtitle)
                .font(.caption)
            Spacer()
        }
    }
}

struct PokemonDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PokemonDetailedView(pokemon: PokemonVM.samples[0])
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}

