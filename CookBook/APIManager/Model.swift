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


enum UrlComponentsData {
    
    case fetchRecipeData(apikey: String,query: String,number: Int,  searchMeh: SearchMethods)
    case fetchRecipeDataById(apikey: String)
    case fetchRecipeIntsructions(apikey: String)
//    case fetchRecipeDatabyIngredients
    
    func getUrl(endpoint: API_ENDPOINTS) throws -> URL? {
        var urlQueryItems: [URLQueryItem]

        
        switch self {
            
        case .fetchRecipeData(let apikey, let query, let number, let searchMeh):
            guard var components = makeurlComponents(endpoint: endpoint) else {
                throw URLError(.badURL)
            }
            
            
            if searchMeh == .SearchByName {
                urlQueryItems = [
                    URLQueryItem(name: "apiKey", value: apikey),
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "number", value: "\(number)"),
                    URLQueryItem(name: "addRecipeInformation", value: "True"),
                    URLQueryItem(name: "titleMatch", value: query),
                    URLQueryItem(name: "instructionsRequired", value: "true")
                    
                ]
                
            }else{
                urlQueryItems = [
                    URLQueryItem(name: "apiKey", value: apikey),
                    URLQueryItem(name: "titleMatch", value: query),
                    URLQueryItem(name: "number", value: "\(number)"),
                    
                    
                ]
            }
            
            
            components.queryItems = urlQueryItems
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
            
            
            
            
        case .fetchRecipeDataById(let apiKey):
            
            guard var components = makeurlComponents(endpoint: endpoint) else {
                throw URLError(.badURL)
            }
            
            
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                
            ]
            
            guard let url = components.url else {
                throw URLError(.badURL)
            }
            
            return url
            
            
            
        case .fetchRecipeIntsructions(let apiKey):
            
            guard var components = makeurlComponents(endpoint: endpoint) else {
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
