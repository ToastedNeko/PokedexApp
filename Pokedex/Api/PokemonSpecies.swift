//
//  PokemonMoves.swift
//  Pokedex
//
//  Created by Kinme on 4/26/23.
//

/*
 
 This view gets the species so that the description of
 each Pokemon can be retrieved for the PokemonDetailView
 
 */

import Foundation

struct PokemonSpecies: Codable{
    var flavor_text_entries: [FlavorTextEntry]
}

struct FlavorTextEntry: Codable{
    var flavor_text: String
}

class PokemonSpeciesApi{
    // once data is retrieved, don't end the function; send it back to us
    func getData(url: String, completion: @escaping (PokemonSpecies) -> ()){
        // if there is a url, load the API request needed
        guard let url = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else{
                return
            }
            // get the list of Pokemon and their results from the url provided
            let pokemonSpecies = try! JSONDecoder().decode(PokemonSpecies.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSpecies)  // data we want to return to the user
            }
        }.resume()
    }
}
