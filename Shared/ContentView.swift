//
//  ContentView.swift
//  Shared
//
//  Created by SuryaKiriti Komma on 15/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    // Instance variable of the class network monitor.
    @ObservedObject var monitor = NetworkMonitor()
    
    // Global variables.
    @State var planet: [Planet] = []
    @State var planet_offline:[Planet] = []
    var body: some View {
        // Displaying the list making an api call.
        if monitor.isConnected {
            List(planet) { item in
                Text(item.name)
            }
            .onAppear{
                Api().getPlanets { planet in
                    self.planet = planet
                    // Assigning to local variable but this will reset when the app is terminated.
                    // ToDo use key-value pair equivalent in swift which stores the (encoded) list locally which can be used to display in offline mode.
                    self.planet_offline = planet
                }
            }
        }
        // Displaying the list when offline.
        else {
            // ToDo: Decode the locally stored list from the key-value pair.
            // Assign it to the variable when in offline and pass it on to the list ui element.
            // For now a local variable is used to store the value but the value of this variable resets when the app is terminated.
            List(planet_offline) { item in
                Text(item.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding(.top, 35.0)
    }
}
