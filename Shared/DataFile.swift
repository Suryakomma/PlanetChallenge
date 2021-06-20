//
//  DataFile.swift
//  TestUniversal
//
//  Created by SuryaKiriti Komma on 16/06/2021.
//

import SwiftUI

// Planet model with all the attributes of each planet.
struct Planet: Codable, Identifiable {
    let id = UUID()
    var name: String
    var rotation_period: String
    var orbital_period: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surface_water: String
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: URL
}

// Response model to fetch the API response.
struct Response: Codable, Identifiable {
    let id = UUID()
    var count: Int
    var next: URL
    var results: [Planet]
}

// Api class which fetches the planet data.
class Api {
    
    // Method to make the api call and fetch the response.
    func getPlanets(completion: @escaping ([Planet]) -> ()) {
        let apiURL = URL(string: "https://swapi.dev/api/planets/")
        
        URLSession.shared.dataTask(with: apiURL!) { (data, _, _) in
            let planets = try! JSONDecoder().decode(Response.self, from: data!)
            completion(planets.results)
        }
        .resume()
    }
}
