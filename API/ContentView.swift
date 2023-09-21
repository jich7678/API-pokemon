//
//  ContentView.swift
//  API
//
//  Created by Sam Chen on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            TabView {
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage:"house")
                    }
                PokemonView()
                    .tabItem {
                        Label("Pokedex", systemImage:"list.bullet")
                    }
                PikachuView()
                    .tabItem {
                        Label("Pikachu", systemImage:"lanyardcard")
                    }
            }
        }
    }
}

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("cardBack")
                    .resizable()
                    .frame(width:400, height:600)
            }.navigationTitle("Pokemons")
        }
    }
}
    #Preview {
        ContentView()
    }

