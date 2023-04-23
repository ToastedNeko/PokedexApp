//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Kinme on 4/22/23.
//

import SwiftUI
import SDWebImage

struct PokemonImage: View {
    var imageLink = ""
    @State private var pokemonSprite = ""
    
    
    var body: some View {
        AsyncImage(url: URL(string: pokemonSprite))
            .frame(width: 75, height: 75)
            .onAppear{
                let loadedData = UserDefaults.standard.string(forKey: imageLink)
                    // no loaded data for current image; not cached
                if loadedData == nil{
                    getSprite(url: imageLink)
                    UserDefaults.standard.set(imageLink, forKey: imageLink)
                    print("new url caching")
                }else{
                    // load the old sprite

                    getSprite(url: loadedData!)
                    print("using cached url")
                }
                
                //if loadedData = SDImageCache.shared().
            }
//            .clipShape(Circle())
//            .foregroundColor(Color.gray.opacity(0.80))
    }
   
    func getSprite(url: String){
        var temporarySprite: String?
        
        PokemonSelectedApi().getData(url: url){ sprite in
            temporarySprite = sprite.front_default
            self.pokemonSprite = temporarySprite ?? "Placeholder"
        }
    }
}



struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage()
    }
}
