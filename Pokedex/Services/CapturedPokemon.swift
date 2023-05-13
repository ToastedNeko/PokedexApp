//
//  CapturedPokemonDictionary.swift
//  Pokedex
//
//  Created by Kinme on 5/11/23.
//

/*
 
 Contains all Pokemon currently available with its
 name and url containing the data:
 https://pokeapi.co/api/v2/pokemon/?offset=0&limit=251
 
 This class allows user to being able to mark a pokemon as captured or not
 in the pokedex. UserDefaults is being used to store each of the Pokemon
 that the user has captured in the PokemonDetailView.
 
 This is displayed in the PokemonDetailView as a pokeball that is gray or red.
 This is also displayed in the PokemonDetailView as a button press and a pokeball
 that is either red or gray.
 
 We discussed UserDefaults in class and I also used references:
 https://www.simpleswiftguide.com/how-to-use-userdefaults-in-swiftui/
 https://www.hackingwithswift.com/books/ios-swiftui/storing-user-settings-with-userdefaults
 
 */

import SwiftUI

class CapturedPokemon: ObservableObject{
    @Published var capturedPokemon: [String: Bool] = [:]
    @Published var currentPokemonIndex: Int = 0
    
    func toggleCapture(pokemonName: String) {
        if let isCaptured = capturedPokemon[pokemonName] {
            capturedPokemon[pokemonName] = !isCaptured
        } else {
            capturedPokemon[pokemonName] = true
        }
        
        saveCapturedPokemon()
    }
    
    func isPokemonCaptured(pokemonName: String) -> Bool{
        return capturedPokemon[pokemonName] ?? false
    }
    
    func saveCapturedPokemon() {
        let capturedPokemonData = try? JSONEncoder().encode(capturedPokemon)
        UserDefaults.standard.set(capturedPokemonData, forKey: "CAPTURED_POKEMON")
    }
    
    func loadCapturedPokemon() {
        guard let capturedPokemonData = UserDefaults.standard.data(forKey: "CAPTURED_POKEMON") else {
            return
        }
        
        if let loadedCapturedPokemon = try? JSONDecoder().decode([String: Bool].self, from: capturedPokemonData) {
            capturedPokemon = loadedCapturedPokemon
            //print(loadedCapturedPokemon)
        }
    }
}
