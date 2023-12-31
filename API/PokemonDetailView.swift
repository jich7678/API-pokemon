//
//  PikachuView.swift
//  API
//
//  Created by Sam Chen on 9/21/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @State var pokeID = String()
    @State var poke = [PokemonDetail]()
    
    func getPoke(withString input: String) async -> () {
        do {
            let url = URL(string: input)!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            let pokemon = try JSONDecoder().decode(PokemonDetail.self, from:data)
            poke.append(pokemon)
        }   catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(poke) { pokemon in
                    VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: "\(String(describing: pokemon.image))/high.webp")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:330,height:400)
                                } else if phase.error != nil {
                                   Image(systemName: "icloud.and.arrow.down.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:330,height:400)
                                } else {
                                    ProgressView()
                                }
                            }
                            Divider()
                            
                            //let _ = print(pokemon.image) debug
                            Text("Name: \(pokemon.name)")
                            Text("ID: \(pokemon.id)")
                            Text("Rarity: \(pokemon.rarity)")
                            Text("HP: \(pokemon.hp)")
                        
                    }.navigationTitle("\(pokemon.name)")
                }
            }
        }.task {
            let input = "https://api.tcgdex.net/v2/en/cards/" + pokeID
            await getPoke(withString: input )
        }
    }
    
    #Preview {
        ContentView()
    }
    
}
