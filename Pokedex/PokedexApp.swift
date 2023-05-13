//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.

// This app is a pokedex that contains 151 different Pokemon and details for them.

import SwiftUI

@main
struct PokedexApp: App {
    @ObservedObject private var capturedPokemon = CapturedPokemon()
    
    var body: some Scene {
        WindowGroup {
            PokedexSplashScreenView()
                .environmentObject(capturedPokemon)
        }
    }
}
