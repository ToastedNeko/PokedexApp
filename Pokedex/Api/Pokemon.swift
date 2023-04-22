//
//  Pokemon.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//
/*
     Contains all Pokemon currently available with its
     name and url containing the data:
     https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1010
 
     Source code used from:
     https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently
 */

import Foundation

// create an array of Pokemon contained
struct Pokemon: Codable{
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable{
    let id = UUID() // should this be let?
    var name: String
    var url: String
}

class PokemonApi{
    // once data is retrieved, don't end the function; send it back to us
    func getData(completion: @escaping ([PokemonEntry]) -> ()){
        // if there is a url, load the API request needed
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1010") else{
            return
        }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else{
                return
            }
            // get the list of Pokemon and their results from the url provided
            let pokemonList = try! JSONDecoder().decode(Pokemon.self, from: data)
            DispatchQueue.main.async {
                completion(pokemonList.results)
            }
        }.resume()
    }
}