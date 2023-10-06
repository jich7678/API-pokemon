//
//  Pokemon.swift
//  API
//
//  Created by Sam Chen on 10/5/23.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var image: String?
}

struct PokemonDetail: Codable, Identifiable {
    var id: String
    var localId: String?
    var name: String
    var rarity: String
    var hp: Int
    var image: String
}
