//
//  PokemonView2.swift
//  API
//
//  Created by Sam Chen on 9/22/23.
//

import SwiftUI

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
        
        //let _ = print(viewModel.pokedex.count) figure out how many total pokemon I have in the list 15986
        
        }
    var searchResults: [Pokemon] {
            if inputID.isEmpty {
                return viewModel.pokedex
            } else {
                return viewModel.pokedex.filter { $0.name.contains(inputID) }
            }
        }
}
