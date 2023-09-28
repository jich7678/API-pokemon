//
//  PikachuView.swift
//  API
//
//  Created by Sam Chen on 9/21/23.
//

import SwiftUI

struct PokemonDetail: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var rarity: String
    var hp: Int
    var image: String
}

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
    
    func checkEmpty(withString picture: String) -> (Bool) {
        var isEmpty = true
        if (picture.contains("http")) {
            isEmpty = false
        }
        return(isEmpty)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                List(poke) { pokemon in
                    VStack(alignment: .leading) {
                            let _ = print(pokemon.image)
                            AsyncImage(url: URL(string: "\(String(describing: pokemon.image))/high.webp")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:330,height:400)
                            } placeholder: {
                                ProgressView()
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
