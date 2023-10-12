//
//  MarkerDetailView.swift
//  API
//
//  Created by Sam Chen on 10/12/23.
//

import SwiftUI

struct MarkerView: View {
    var pokemon: Pokemon
    var pushNotifService = PushNotificationService()
    
    var body: some View {
        VStack {
            Text("\(pokemon.name) Has Appeared!")
            Text("ID: \(pokemon.id)")
            
            Button("Allow Push Notification") {
                pushNotifService.requestPermissions()
            }
            .padding(.vertical, 16)
            
            Button("Remind me to Catch \(pokemon.name)") {
                pushNotifService.scheduleNotification(
                    title: ("\(pokemon.name) Has Appeared!"),
                    subtitle: "Don't forget to catch \(pokemon.name)"
                )
            }
            .padding(.vertical, 16)
        }
    }
}
