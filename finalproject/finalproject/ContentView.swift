import SwiftUI
//
//  ContentView.swift
//  finalproject
//
//  Created by Rudy Patel on 4/12/25.
//

struct GameView: View {
    @State private var currentPokemon: Pokemon?
    @State private var userGuess: String = ""
    @State private var showAnswer: Bool = false
    @State private var message: String = "Who's that Pokémon?" //@State bc I change message sometimes
    @State private var isLoading: Bool = true
    
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Pokémon Guesser")
                .font(.largeTitle)
                .padding()
            
            if isLoading {
                ProgressView()
                    .padding()
                Text("Loading...") //takes time to get pokemon so had to create loading portion
            } else if let pokemon = currentPokemon { //when loaded actually uploads sprite
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .brightness(showAnswer ? 0 : -1)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 200, height: 200)
                }
                
                Text(message) //"Whos that pokemon?"
                    .font(.headline)
                    .padding()
                
                TextField("Enter your guess", text: $userGuess)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding(.horizontal)
                    .disabled(showAnswer) //turns off text box after answering
                
                Button(action: {
                    if showAnswer {
                        // Load new Pokémon
                        loadNewPokemon()
                    } else {
                        checkAnswer()
                    }
                }) {
                    Text(showAnswer ? "Next Pokémon" : "Guess")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            } else {
                Text("Couldn't load Pokémon")
                Button("Try Again") {
                    loadNewPokemon()
                }
            }
        }
        .padding()
        .onAppear(perform: loadNewPokemon) //starts the app on open
    }
    
    
    func loadNewPokemon() {
        //UI reset and picks the pokemon
        isLoading = true
        showAnswer = false
        userGuess = ""
        message = "Who's that Pokémon?"
        //this is what grabs the pokemon, uses function from API
        PokemonManager.getRandomPokemon { pokemon in
            self.currentPokemon = pokemon
            self.isLoading = false
        }
    }
    
    func checkAnswer() {
        if let pokemon = currentPokemon {
            if userGuess.lowercased() == pokemon.name {
                message = "You got it right✅! It's \(pokemon.name.capitalized)!"
            } else {
                message = "Wrong❌! \(pokemon.name)!"
            }
            showAnswer = true
        }
    }
}

#Preview {
    GameView()
}
