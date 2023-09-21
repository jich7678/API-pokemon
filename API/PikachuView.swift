//
//  PikachuView.swift
//  API
//
//  Created by Sam Chen on 9/21/23.
//

import SwiftUI

struct Pikachu: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var rarity: String
    var hp: String
    var description: String
    
}

struct PikachuView: View {
    @State var poke = [Pikachu]()
    
    func getPikachu() async -> () {
        do {
            let url = URL(string: "https://api.tcgdex.net/v2/en/cards/basep-1")!
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            poke = try JSONDecoder().decode([Pikachu].self, from:data)
        }   catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                List(poke) { pikachu in
                     VStack(alignment: .leading) {
                         Text("Name: \(pikachu.name)")
                         Text("ID: \(pikachu.id)")
                         Text("Rarity: \(pikachu.rarity)")
                         Text("HP: \(pikachu.hp)")
                         Text("Description: \(pikachu.description)")
                     }
                 }
            } .navigationTitle("Pikachu")
        }.task {
            await getPikachu()
        }
    }
}

#Preview {
    ContentView()
}

