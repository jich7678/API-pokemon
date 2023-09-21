//
//  ChampionView.swift
//  API
//
//  Created by Sam Chen on 9/20/23.
//

import SwiftUI

struct Pokemon: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var image: String?
    
}

struct PokemonView: View {
    @State var pokedex = [Pokemon]()
    
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
    var body: some View {
        NavigationView {
            VStack {
                   List(pokedex) { pokemon in
                        VStack(alignment: .leading) {
                            Text(pokemon.name)
                            Text("ID: \(pokemon.id)")
                        }
                    }
            } .navigationTitle("Pokedex")
        }.task {
            await getAllPokemons()
        }
    }
}

#Preview {
    ContentView()
}
