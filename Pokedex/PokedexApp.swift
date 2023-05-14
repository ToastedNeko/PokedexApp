//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//
// This app is a pokedex that contains 251 different Pokemon and details for them.
/*
 
 Environment Objects:
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
 https://developer.apple.com/documentation/swiftui/environmentobject
 
 */

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
