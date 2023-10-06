//
//  File.swift
//  API
//
//  Created by Sam Chen on 10/5/23.
//

import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {
    
    @Published var pokedex = [Pokemon]()
    
    init() {
        Task {
            await getAllPokemons()
        }
    }
    
    @MainActor
    func getAllPokemons() async -> () {
        do {
            let url = URL(string: "https://api.tcgdex.net/v2/en/cards")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            pokedex = try JSONDecoder().decode([Pokemon].self, from:data)
        }   catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
