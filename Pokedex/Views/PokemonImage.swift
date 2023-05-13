//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//

/*
 
    Source code used from:
    https://www.youtube.com/watch?v=dmIot8Weoxg&ab_channel=Indently

 */

import SwiftUI
import SDWebImage
import CachedAsyncImage
import Foundation

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    var body: some View {
        CachedAsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 85, height: 85)
           
            .onAppear{
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                
                    // no loaded data for current image; not cached
                if loadedData == nil{
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                    
                   // print("new url caching")
                }else{
                    
                    // load the old sprite
                    getSprite(url: loadedData!)
                   // print("using cached url")
                }
                
            }
                
//            .clipShape(Circle())
//            .foregroundColor(Color.gray.opacity(0.80))
            .background(Image("Placeholder").opacity(0.10).frame(width:0.01, height: 0.01))
                
    }
   
    func getSprite(url: String){
        var temporarySprite: String?
        
        PokemonSelectedApi().getData(url: url){ selected in
            temporarySprite = selected.sprites.front_default
            self.pokemonSprite = temporarySprite ?? "Pokeball"
        }
    }
}



struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
