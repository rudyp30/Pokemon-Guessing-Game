//
//  API.swift
//  finalproject
//
//  Created by Rudy Patel on 4/13/25.
//
import Foundation
import SwiftUI

class PokemonManager {
    static func getRandomPokemon(completion: @escaping (Pokemon?) -> Void) { //grabs pokemon from whichever gen I uncomment
        //let randomId = Int.random(in: 1...151) //gen 1
        //let randomId = Int.random(in: 152...251) //gen 2
        let randomId = Int.random(in: 252...386) //gen 3
        //let randomId = Int.random(in: 387...493) //gen 4
        //let randomId = Int.random(in: 494...649) //gen 5
        //let randomId = Int.random(in: 650...721) //gen 6
        //let randomId = Int.random(in: 722...809) //gen 7
        
        //randomId is now whichever pokemon the .random chose
    
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomId)") else {
            completion(nil) //URL for the API, holds whichever pokemon got chossn
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return //returns the data from API after grabbed
            }
            
            /*
             Had to search this didnt know how to use decoder
             decodes the JSON data and allows us to use it in contentview
             */
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    completion(pokemon)
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
