//
//  PokemonView2.swift
//  API
//
//  Created by Sam Chen on 9/22/23.
//

import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var image: String?
}

struct PokemonView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var inputID = ""

    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(searchResults, id: \.id) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokeID: pokemon.id)) {
                                VStack {
                                    Text(pokemon.name)
                                    Text("ID: \(pokemon.id)")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
            .searchable(text: $inputID, prompt: "Enter Pokemon Name")
        }
    var searchResults: [Pokemon] {
            if inputID.isEmpty {
                return viewModel.pokedex
            } else {
                return viewModel.pokedex.filter { $0.name.contains(inputID) }
            }
        }
}


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
