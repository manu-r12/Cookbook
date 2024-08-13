//
//  APIManager .swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation


fileprivate func makeurlComponents(endpoint: API_ENDPOINTS) -> URLComponents? {
    
    guard let urlComponents = URLComponents(
        string: endpoint.url) else {
        return nil
    }
    
    return urlComponents
}

// MARK: APIManager
/// responsible for handling all api related calles (for example: recipe api)
class APIManager {
    
    var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: Fetch Recipe Info
    func fetchRecipesInfo(query: String,
                          numberOfRes: Int,
                          searchMethod: SearchMethods) async throws -> FetchedItem
    
    {
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}
        
        
        
        guard let url = try UrlComponentsData.fetchRecipeData(
            apikey: apiKey,
            query: query,
            number: numberOfRes,
            searchMeh: searchMethod
        ).getUrl(endpoint: .GET_RECIPE_INFO) else {throw URLError(.badURL)}
        
        
        let (data, res) = try await urlSession.data(from: url)
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedRecipeData = try JSONDecoder().decode(
            FetchedItem.self,
            from: data
        )
        
        return fetchedRecipeData
    }
    
    
    
    // MARK: Fetch Ingredients By Recipe Id
    func fetchIngredientsByRecipeId(id: Int) async throws -> FetchedIngredientsByRecipeID? {
        
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}
        
        
        guard let url = try UrlComponentsData.fetchRecipeDataById(apikey: apiKey).getUrl(
            endpoint: .GET_INGREDIENTS_BY_RECIPE_ID(id: id)
        ) else {throw URLError(.badURL)}
        
        
        let (data, res) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedIngredientsData = try JSONDecoder().decode(FetchedIngredientsByRecipeID.self, from: data)
        
        return fetchedIngredientsData
    }
    
    
    
    
    // MARK: Fetch Instcutions for a Recipe by Recipe Id
    
    func fetchInstructionsForARecipe(id: Int) async throws -> [RecipeInstrcutions]? {
        
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}
        
        guard let url = try UrlComponentsData.fetchRecipeIntsructions(apikey: apiKey).getUrl(
            endpoint: .GET_INSTRUCTIONS(id: id)
        ) else {throw URLError(.badURL)}
        
        
        let (data, res) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedIngredientsData = try JSONDecoder().decode([RecipeInstrcutions].self, from: data)
        
        return fetchedIngredientsData
    }
    
    
    //MARK: Generic Function
//    func fetchRecipeByIngredients<T : Codable>(modelType: T, id: Int) async throws ->  T? {
//        
//        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}
//        
//        // The URL for fetching recipe info by ingredients
//        guard var urlComponents = makeurlComponents(
//            endpoint: API_ENDPOINTS.GET_INSTRUCTIONS(id: id)
//        ) else {throw URLError(.badURL)}
//        
//        
//        // can we make it reusable
//        urlComponents.queryItems = [
//            URLQueryItem(name: "apiKey", value: apiKey),
//            
//        ]
//        
//        
//        
//        return nil
//    }
    
    
    func fetchRecipeByIngredients(ingredients: String) async throws -> [FetchedRecipeByIngredients]? {
        
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}
        
        guard let url = try UrlComponentsData.fetchRecipeDatabyIngredients(
            apikey: apiKey,
            ingredients: ingredients
        ).getUrl(endpoint: .GET_RECIPE_BY_INGREDIENTS)
         else {throw URLError(.badURL)}
        
        
        let (data, res) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedIngredientsData = try JSONDecoder().decode([FetchedRecipeByIngredients].self, from: data)
        
        return fetchedIngredientsData
    }
}
