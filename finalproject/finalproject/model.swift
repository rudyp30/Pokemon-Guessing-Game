//
//  model.swift
//  finalproject
//
//  Created by Rudy Patel on 4/13/25.
//

import Foundation
import SwiftUI

struct Pokemon: Codable {
    let name: String
    let sprites: Sprites //this gets us the image
    
    struct Sprites: Codable {
        let frontDefault: String //hold the URL to the sprite
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default" //used GPT, maps the JSON key "front_default" to Swift's camelCase property name "frontDefault"
        }
    }
}
