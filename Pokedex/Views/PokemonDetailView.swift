//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//
// 


import SwiftUI

struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0, species: Species(), types: [PokemonType]())
    @State var pokemonSpecies = PokemonSpecies(flavor_text_entries: [FlavorTextEntry]())
    @State var flavorText = ""
    @State var showPokeBall = "GrayPokeball3"
    let userDefaultCaptured = UserDefaults.standard
    
    // Get userdefault data in order to save the user's selection
    // pass this information to the pokedexpokemonview
    
    var body: some View {
        ScrollView{
            LazyVStack{
                VStack{
                    
                    Spacer().frame(height: 5)
                    
                    // Display the Pokemon Entry
                    Text(" POKEMON ENTRY ").background(Color.white).cornerRadius(6).padding(EdgeInsets(top: 1, leading: 5, bottom: 1, trailing: 5)).font(.custom("GillSans", size: 28))
                        .bold()
                    
                    Spacer().frame(height: 5)
                    
                }.fixedSize().cornerRadius(6).padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30)).background(.yellow).shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                )
                
                Spacer().frame(height: 25)
                
                VStack{
                    
                    Spacer().frame(height: 10)
                    
                    VStack(spacing: 6){
                        
                        // Display Pokemon Entry details from API
                        Text(pokemonEntry.name.capitalized)
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                        
                    }.background(Color.white).cornerRadius(6).fixedSize(horizontal: false, vertical: true).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).multilineTextAlignment(.leading)
                    Spacer().frame(height: 5)
                }
                .font(.custom("GillSans", size: 25))
                .cornerRadius(5).padding(EdgeInsets(top: 0, leading: 100, bottom: 5, trailing: 100)).background(.yellow).shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                )
                
                VStack{
                    
                    Spacer().frame(height: 1)
                    
                    // Display Pokemon sprite from API
                    if (pokemonSelected.sprites.front_default != nil) {
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.40).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                    }
                    Spacer().frame(height: 1)
                }
                
                VStack(alignment: .leading, spacing: 6){
                    
                    HStack{
                        
                        // Display description of Pokemon
                        Text(self.flavorText).fixedSize(horizontal: false, vertical: true).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).multilineTextAlignment(.leading)
                        
                    }.cornerRadius(2).padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)).background(Color.white)
                        .font(.custom("GillSans", size: 25))
                    
                }.cornerRadius(15).padding(EdgeInsets(top: 10, leading: 80, bottom: 10, trailing: 80)).background(.yellow).shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8).overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                )
                
                Spacer().frame(height: 5)
                
                VStack{
                    
                    // Allows the user to mark the Pokemon as captured or not
                    Image(showPokeBall)
                        .aspectRatio(contentMode: .fit)
                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                    
                    Button(action: {
                        self.showPokeBall = "PokeBall3"
                        userDefaultCaptured.set(self.showPokeBall, forKey: "Captured")
                    }, label: {
                        Text("Captured")
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .font(.custom("GillSans", size: 25))
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            
                    }).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 4)
                    ).shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)
                    
                    Spacer().frame(height: 5)

                }.padding(EdgeInsets(top: 50, leading: 0, bottom: 10, trailing: 0))
                
            }.background(Image("Grid").opacity(0.10))
            
        }
        .onAppear{
            getData(url: pokemonEntry.url)
        }
    }
    
    // Get Pokemon description from API
    func getData(url: String){
        PokemonSelectedApi().getData(url: url){ data in
            
            self.pokemonSelected = data
            let speciesUrl = data.species.url
            
            PokemonSpeciesApi().getData(url: speciesUrl){ speciesData in
                self.pokemonSpecies = speciesData
                self.flavorText = speciesData.flavor_text_entries[0].flavor_text
            }
        }
    }
}

//struct PokemonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView(pokemonEntry: PokemonEntry)
//    }
//}


