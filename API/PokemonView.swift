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
    

    var body: some View {
        
        NavigationView {
            VStack {
/*                List(viewModel.pokedex) { pokemon in
                        VStack(alignment: .leading) {
                            Text(pokemon.name)
                            Text("ID: \(pokemon.id)")
                        }
                    }
*/
                List {
                    ForEach(viewModel.pokedex) { pokemon in 
                        if (pokemon.id == "basep-1") {
                            NavigationLink(destination: PikachuView()) {
                                VStack {
                                    Text(pokemon.name)
                                    Text("ID: \(pokemon.id)")
                                }
                            }
                        }
                        else {
                            VStack(alignment: .leading) {
                                Text(pokemon.name)
                                Text("ID: \(pokemon.id)")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
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
