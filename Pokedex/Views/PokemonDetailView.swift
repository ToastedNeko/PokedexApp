//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Kinme on 4/23/23.
//
//

/*
 
 This displays the details of a Pokemon selected by user
 in the PokedexPokemonView.
 
 It displays the name, number, weight, height, and description
 of the Pokemon chosen.
 
 */


import SwiftUI


struct PokemonDetailView: View {
    var pokemonEntry: PokemonEntry
    @State var pokemonSelected = PokemonSelected(sprites: PokemonSprites(), name: "", weight: 0, height: 0, species: Species(), types: [PokemonType]())
    @State var pokemonSpecies = PokemonSpecies(flavor_text_entries: [FlavorTextEntry]())
    @State var flavorText = ""
    @State var showPokeBall = "GrayPokeball3"
    @EnvironmentObject var capturedPokemon: CapturedPokemon
    
    var body: some View {
        ScrollView{
            LazyVStack{
                VStack{
                    
                    Spacer().frame(height: 5)
                    
                    // Display the Pokemon Entry
                    Text(pokemonEntry.name.uppercased())
                        .frame(width: 285, height: 50)
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                        .font(.custom("GillSans", size: 26))
                        .bold()
                    
                    Spacer().frame(height: 5)
                    
                }.cornerRadius(5)
                    .background(.yellow)
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 5)
                    )
                
                Spacer().frame(height: 25)
                
                VStack {
                    Spacer().frame(height: 5)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        // Display Pokemon Entry details from API
                        Text("Number: \(capturedPokemon.currentPokemonIndex)")
                        Text("Height: " + String(round(Double(pokemonSelected.height) * 3.93701 )) + "\"")
                        Text("Weight: " + String(round(Double(pokemonSelected.weight) / 4.536)) + " lbs")
                    }
                    .frame(width: 285, height: 115)
                    .font(.custom("GillSans", size: 22))
                    .background(Color.white)
                    .cornerRadius(6)
                    .padding(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                    .multilineTextAlignment(.leading)
                    
                    Spacer().frame(height: 5)
                }
                .cornerRadius(5)
                .background(.yellow)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                )
                
                VStack{
                    
                    Spacer().frame(height: 1)
                    
                    // Display Pokemon sprite from API
                    if (pokemonSelected.sprites.front_default != nil) {
                        AsyncImage(url: URL(string: pokemonSelected.sprites.front_default!), scale: 0.55)
                            .padding(EdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
                        
                    }
                    
                    Spacer().frame(height: 1)
                }
                
                VStack(alignment: .leading, spacing: 6){
                    
                    VStack{
                        
                        // Display description of Pokemon
                        Text(self.flavorText)
                            .frame(width: 270, height: 200)
                            .font(.custom("GillSans", size: 22))
                            .background(Color.white)
                            .cornerRadius(6)
                            .padding(EdgeInsets(top: 10, leading: 37, bottom: 10, trailing: 37))
                            .multilineTextAlignment(.leading)
                        
                    }
                    
                }
                .cornerRadius(5)
                .background(.yellow)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                )
                
                Spacer().frame(height: 1)
                
                VStack{
                    
                    // Allows the user to mark the Pokemon as captured or not
                    Button(action: {
                        capturedPokemon.toggleCapture(pokemonName: pokemonEntry.name)
                        
                    }) {
                        
                        VStack(spacing: 15){
                            if(capturedPokemon.isPokemonCaptured(pokemonName: pokemonEntry.name)){
                                Image("PokeBall3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                            }else{
                                Image("GrayPokeball3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                    .opacity(0.4)
                            }
                            
                            Text(capturedPokemon.isPokemonCaptured(pokemonName: pokemonEntry.name) ? "Not Captured" : "Captured")
                                .padding()
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(red: 0.82, green: 0.18, blue: 0.18), Color(red: 0.72, green: 0.08, blue: 0.08)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 3)
                                )
                        }
                        .padding(EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 20))
                    }
                }
            }
            .background(Image("Grid").opacity(0.10))
        }
        .onAppear{
            getData(url: pokemonEntry.url)
            capturedPokemon.loadCapturedPokemon()
            //            print(capturedPokemon.isPokemonCaptured(pokemonName: pokemonEntry.name))
            //            print(pokemonEntry)
            //            print(pokemonEntry.id)
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

// Allows the user to mark the Pokemon as captured or not
//                    Image(showPokeBall)
//                        .aspectRatio(contentMode: .fit)
//                        .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
//
//                    Button(action: {
//                        self.showPokeBall = "PokeBall3"
//                        userDefaultCaptured.set(self.showPokeBall, forKey: "Captured")
//                    }, label: {
//                        Text("Captured")
//                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
//                            .font(.custom("GillSans", size: 25))
//                            .background(Color.blue)
//                            .foregroundColor(Color.white)
//                            .cornerRadius(10)
//
//                    }).overlay(
//                        RoundedRectangle(cornerRadius: 10)
//                            .stroke(Color.black, lineWidth: 4)
//                    ).shadow(color: .black.opacity(0.4), radius: 5, x: 8, y: 8)
//
//                    Spacer().frame(height: 5)
