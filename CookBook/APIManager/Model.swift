//
//  Model.swift
//  CookBook
//
//  Created by Manu on 2024-08-09.
//

import Foundation

enum API_ENDPOINTS {
    case GET_RECIPE_INFO
    case GET_INGREDIENTS_BY_RECIPE_ID(id: Int)
    case GET_INSTRUCTIONS(id: Int)
    
    var url: String {
        switch self {
        case .GET_RECIPE_INFO:
            return "https://api.spoonacular.com/recipes/complexSearch"
        case .GET_INGREDIENTS_BY_RECIPE_ID(let id):
            return "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json"
        case .GET_INSTRUCTIONS(id: let id):
            return "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions"
        }
    }
}
