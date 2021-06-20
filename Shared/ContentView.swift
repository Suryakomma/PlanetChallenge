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
    
    let defaults = UserDefaults.standard
    
    // Global variables.
    @State var planet: [Planet] = []
    @State var planet_offline:[Planet] = []
    var body: some View {
        
        List(planet) { item in
            Text(item.name)
        }
        .onAppear{
            // Displaying the list making an api call when connected to internet.
            if monitor.isConnected {
                Api().getPlanets{ planet in
                    self.planet = planet
                }
            }
            // Displaying the offline list stored locally.
            else {
                self.planet = retrieveOffline()
            }
        }
    }
    
    // Function to save the list locally.
    func saveOffline(planet: [Planet]) {
        
        // Encode the values before storing in userdefaults.
        let encoded = try? JSONEncoder().encode(planet)
        defaults.setValue(encoded, forKey: "OfflineList")
    }
    
    // Function to retrieve the locally saved list.
    func retrieveOffline() -> [Planet] {
        if let savedList = defaults.object(forKey: "OfflineList") as? Data,
           let loadedList = try? JSONDecoder().decode([Planet].self, from: savedList){
                self.planet_offline = loadedList
            }
        return self.planet_offline
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .padding(.top, 35.0)
    }
}
