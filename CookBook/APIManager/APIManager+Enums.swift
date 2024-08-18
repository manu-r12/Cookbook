//
//  Model.swift
//  CookBook
//
//  Created by Manu on 2024-08-09.
//

import Foundation


fileprivate func makeurlComponents(endpoint: API_ENDPOINTS) -> URLComponents? {
    
    guard let urlComponents = URLComponents(
        string: endpoint.url) else {
        return nil
    }
    
    return urlComponents
}


enum API_ENDPOINTS {
    
    case GET_RECIPE_INFO
    
    case GET_RECIPE_BY_ID(id: Int)
    
    case GET_INGREDIENTS_BY_RECIPE_ID(id: Int)
    
    case GET_INSTRUCTIONS(id: Int)
    
    case GET_RECIPE_BY_INGREDIENTS
    
    
    var url: String {
        switch self {
        case .GET_RECIPE_INFO:
            return "https://api.spoonacular.com/recipes/complexSearch"
            
        case .GET_INGREDIENTS_BY_RECIPE_ID(let id):
            return "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json"
            
        case .GET_INSTRUCTIONS(id: let id):
            return "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions"
            
        case .GET_RECIPE_BY_INGREDIENTS:
            return "https://api.spoonacular.com/recipes/findByIngredients"
            
        case .GET_RECIPE_BY_ID(id: let id):
            return "https://api.spoonacular.com/recipes/\(id)/information"
        }
    }
    
}


enum UrlComponentsData {
    
    case fetchRecipeData(query: String,number: Int,  searchMeh: SearchMethods)
    case fetchRecipeById(id: Int)
    case fetchRecipesIngredientsById(id: Int)
    case fetchRecipeIntsructions(id: Int)
    case fetchRecipeDatabyIngredients(ingredients: String)
    
    // this fucntion is used for returning url for api call
    func getUrl() throws -> URL? {
        var urlQueryItems: [URLQueryItem]
        
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}


        
        switch self {
            
        case .fetchRecipeData(let query, let number, let searchMeh):
            guard var components = makeurlComponents(endpoint: .GET_RECIPE_INFO) else {
                throw URLError(.badURL)
            }
            
            
            
            if searchMeh == .SearchByName {
                urlQueryItems = [
                    URLQueryItem(name: "apiKey", value: apiKey),
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "number", value: "\(number)"),
                    URLQueryItem(name: "addRecipeInformation", value: "True"),
                    URLQueryItem(name: "titleMatch", value: query),
                    URLQueryItem(name: "instructionsRequired", value: "true")
                    
                ]
                
            }else{
                urlQueryItems = [
                    URLQueryItem(name: "apiKey", value: apiKey),
                    URLQueryItem(name: "titleMatch", value: query),
                    URLQueryItem(name: "number", value: "\(number)"),
                    
                    
                ]
            }
            
            
            components.queryItems = urlQueryItems
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
            
            
            
            
        case .fetchRecipesIngredientsById(let id):
            
            guard var components = makeurlComponents(endpoint: .GET_INGREDIENTS_BY_RECIPE_ID(id: id)) else {
                throw URLError(.badURL)
            }
            
            
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
            
            
            
        case .fetchRecipeIntsructions(let id):
            
            guard var components = makeurlComponents(endpoint: .GET_INSTRUCTIONS(id: id)) else {
                throw URLError(.badURL)
            }
            
            
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
  
            
        case .fetchRecipeDatabyIngredients(let ingredients):
            let number = 10
            guard var components = makeurlComponents(endpoint: .GET_RECIPE_BY_INGREDIENTS) else {
                throw URLError(.badURL)
            }
            
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "ingredients", value: ingredients),
                URLQueryItem(name: "number", value: "\(number)"),
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
            
        case .fetchRecipeById(id: let id):
            guard var components = makeurlComponents(endpoint: .GET_RECIPE_BY_ID(id: id)) else {
                throw URLError(.badURL)
            }
            
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
        }
    }
}
