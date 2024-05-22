//
//  File.swift
//  CookBook
//
//  Created by Manu on 2024-04-20.
//

import Foundation

struct Category: Hashable{    
    let name: String
    let emoji: String
}


struct Recipe: Hashable {
    let name: String
    let image: String
    let description: String
}

class DummyData {
    var catogories: [Category] = [.init(name: "Breakfast", emoji: "🥘"),
                                  .init(name: "Lunch", emoji: "🍔"),
                                  .init(name: "Dinner", emoji: "🥗"),
                                  .init(name: "Dessart", emoji: "🍧"),
                                  .init(name: "Non Veg", emoji: "🍗")
                                 ]
    
    var foods : [Recipe] = 
    [
        .init(name: "Tacos", image: "food1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet justo elit. Sed ultricies eget justo in ornare. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Interdum "),
        .init(name: "Chilaquiles", image: "food2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet justo elit. Sed ultricies eget justo in ornare. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Interdum "),
        .init(name: "Pazole", image: "food3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet justo elit. Sed ultricies eget justo in ornare. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Interdum ")
    ]
}
