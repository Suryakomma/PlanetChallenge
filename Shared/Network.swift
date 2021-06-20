//
//  Network.swift
//  TestUniversal
//
//  Created by SuryaKiriti Komma on 20/06/2021.
//

import Foundation
import Network

// Class to check for the changes in the network.
class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            // As we are using the published variable to alter the UI elements , we are going to execute it on main thread.
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
