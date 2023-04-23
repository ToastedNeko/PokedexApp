//
//  PokemonSelected.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//
/*
    https://pokeapi.co/api/v2/pokemon/?offset=0&limit=1010
 
    Source code used from:
    https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently
 */

import Foundation
import SDWebImage

struct PokemonSelected: Codable{
    var sprites: PokemonSprites
    var weight: Int
    var height: Int
    //var base_experience: Int
    //var types: String
    //var abilities: String
    //var details: String
    //var location_area_encounters: String
}

struct PokemonSprites: Codable{
    var front_default: String?
}

class PokemonSelectedApi{
    // once data is retrieved, don't end the function; send it back to us
    func getData(url: String, completion: @escaping (PokemonSprites) -> ()){
        // if there is a url, load the API request needed
        guard let url = URL(string: url) else{
            return
        }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            guard let data = data else{
                return
            }
            // get the list of Pokemon and their results from the url provided
            let pokemonSprite = try! JSONDecoder().decode(PokemonSelected.self, from: data)
            
            DispatchQueue.main.async {
                completion(pokemonSprite.sprites)  // data we want to return to the user
            }
        }.resume()
    }
}
