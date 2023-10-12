//
//  MapView.swift
//  API
//
//  Created by Sam Chen on 10/12/23.
//

import SwiftUI
import MapKit

struct MapPageView: View {
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var randomCoordinate: CLLocationCoordinate2D?
    
    //var randomNumber = Int.random(in:1...15986)
    
    var randomPokemon: [Pokemon] {
        let shuffledArray = viewModel.pokedex
        let newArray = Array(shuffledArray.prefix(10))
        return newArray
    }
    
    var body: some View {
        Map{
            ForEach(randomPokemon) { pokemon in
                Annotation(pokemon.name, coordinate: generateRandomUSCoordinate()) {
                    NavigationLink {
                        MarkerView(pokemon: pokemon)
                    } label: {
                        Image("pokeball")
                            .resizable()
                            .frame(width:20, height:20)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
    
    func generateRandomUSCoordinate() -> CLLocationCoordinate2D {
            // The range of latitude and longitude for the United States
            let minLatitude: Double = 24.396308
            let maxLatitude: Double = 49.384358
            let minLongitude: Double = -125.000000
            let maxLongitude: Double = -66.934570

            // Generate random coordinates within the specified range
            let randomLatitude = Double.random(in: minLatitude...maxLatitude)
            let randomLongitude = Double.random(in: minLongitude...maxLongitude)

            return CLLocationCoordinate2D(latitude: randomLatitude, longitude: randomLongitude)
        }
}
