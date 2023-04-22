//
//  ContentView.swift
//  Pokedex
//
//  Created by Kinme on 4/20/23.
//
/*
    This displays all of the Pokemon entries available in
    the Pokedex
 */

import SwiftUI
import SSSwiftUIGIFView
import SDWebImage

struct ContentView: View {
    var body: some View {
        
        NavigationView{
                Text("Content")
                    .bold()
            }.background(Color.black.ignoresSafeArea())
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
