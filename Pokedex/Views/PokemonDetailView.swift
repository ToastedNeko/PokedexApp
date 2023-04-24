//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//

import SwiftUI

struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0)
    
    
    var body: some View {
        NavigationView{
            
            VStack(alignment: .center){
                VStack(alignment: .leading, spacing: 6){
                   
                    Text(pokemonEntry.name.capitalized)
                    Text("Type: Ball")
                    Text("Height: " + String(pokemonSelected.height))
                    Text("Weight: " + String(pokemonSelected.weight))
                   
                }
                .background(Color.yellow.cornerRadius(15).frame(width: 360, height: 170).border(.black, width: 4))
                    //.position(x: 196, y: 100)
                    .font(.custom("GillSans", size: 25))
                   
                    Divider()
                    if (pokemonSelected.sprites.front_default != nil) {
                        PokemonImage(imageLink: "\(pokemonSelected.sprites.front_default)").frame(width: 250, height: 250).padding()
                    }
                    Divider()
                    
                    
                   // HStack{
                VStack{
                    Text("Description of the Pokeball and its details")
                        .font(.custom("GillSans", size: 25))
                        .background(Color.yellow.frame(width: 360, height: 100).cornerRadius(15))
                    //.position(y: 100)
                }
  
                    //} .font(.custom("GillSans", size: 25))
                    
                
                
                
//                Image("Pokeball2").position(x: 200, y: 250)
                
            }.background(Image("Grid").opacity(0.20))
//            VStack(alignment: .center){
//
//                Image("Pokeball2")
//
//            }.position(x: 200, y: 200)
            
//            VStack{
//                Text("Name: ")
//                Text("Type: ")
//                Text("Weight: ")
//                Text("Height: ")
//
//            }.font(.custom("GillSans", size: 25))
        }
        .onAppear{
            getData(url: pokemonEntry.url)
        }
    }
    
    func getData(url: String){
        PokemonSelectedApi().getData(url: url){ data in
            self.pokemonSelected = data
        }
    }
}

//struct PokemonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView(pokemonEntry: PokemonEntry)
//    }
//}
