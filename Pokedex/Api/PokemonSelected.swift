//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//
/*
    Contains pokemon from generations 1 and 2
    https://pokeapi.co/api/v2/pokemon/?offset=0&limit=251
 
    Source code used from:
    https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently
 
    This api call is getting the details within each Pokemon
 */

import Foundation
import SDWebImage

struct Species: Codable{
    var name: String = ""
    var url: String = ""
}

struct PokemonType: Codable{
    var type: PokemonTypeType
}

struct PokemonTypeType: Codable{
    var name: String = ""
}

struct PokemonSelected: Codable{
    var sprites: PokemonSprites
    var name: String
    var weight: Int
    var height: Int
    var species: Species
    var types: [PokemonType]
}

struct PokemonSprites: Codable{
    var front_default: String?
    //var other: String?
}

class PokemonSelectedApi{
    // once data is retrieved, don't end the function; send it back to us
    func getData(url: String, completion: @escaping (PokemonSelected) -> ()){
        // if there is a url, load the API request needed
        guard let url = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else{
                return
            }
            // get the list of Pokemon and their results from the url provided
            let pokemonSelected = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSelected)  // data we want to return to the user
            }
        }.resume()
    }
}
