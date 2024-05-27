//
//  PokemonVM.swift
//  Pokemon
//
//  Created by Lisandre Taylor on 24/05/2024.
//

import Foundation
import SwiftUI

class PokemonVM: Identifiable, Hashable, Comparable, ObservableObject {
    
    let id: UUID
    let name: String
    var detailsURL: String?
    @Published var spriteURL: String?
    
    var isFullyLoaded: Bool {
        if spriteURL != nil {
            return true
        }
        return false
    }
    
    init(_ name: String, details: String? = nil, sprite: String? = nil) {
        self.id = UUID()
        self.name = name
        self.detailsURL = details
        self.spriteURL = sprite
    }
    
    static func == (lhs: PokemonVM, rhs: PokemonVM) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
    static func < (lhs: PokemonVM, rhs: PokemonVM) -> Bool {
        return lhs.name < rhs.name ? true : false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    func getSprite() async -> UIImage {
        let placeholder = UIImage(systemName: "fossil.shell.fill")!
        if let spriteURLString = self.spriteURL,
           let url = URL(string: spriteURLString) {
            do {
//                let data = try Data(contentsOf: url)
//                let image = UIImage(data: data)
//                return image
                
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
                print("Finished loading image")
                return UIImage(data: data) ?? placeholder
            } catch {
                return placeholder
            }
        }
        return placeholder
    }
}

