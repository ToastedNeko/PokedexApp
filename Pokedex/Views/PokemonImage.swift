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
        AsyncImage(url: URL(string: pokemonSprite), scale: 0.68)
            .frame(width: 100, height: 100)
            //.scaledToFit()
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
