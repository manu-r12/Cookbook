//
//  APIManager .swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation



// MARK: APIManager
/// responsible for handling all api related calles (for example: recipe api)
class APIManager {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    // MARK: Fetch Recipe Info
    func fetchRecipesInfo(query: String,
                          numberOfRes: Int,
                          searchMethod: SearchMethods) async throws -> FetchedItem
    
    {
                
        
        guard let url = try UrlComponentsData.fetchRecipeData(
            query: query,
            number: numberOfRes,
            searchMeh: searchMethod
        ).getUrl() else {throw URLError(.badURL)}
        
        
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
    
    
    func fetchRecipeById(id: Int) async throws -> FetchedRecipe? {
        
        
        guard let url = try UrlComponentsData.fetchRecipeById(id: id).getUrl() else {throw URLError(.badURL)}
        
        let (data, res) = try await urlSession.data(from: url)
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedRecipeData = try JSONDecoder().decode(
            FetchedRecipe.self,
            from: data
        )
        
        return fetchedRecipeData
        
    }
    
    
    // MARK: Fetch Ingredients By Recipe Id
    func fetchIngredientsByRecipeId(id: Int) async throws -> FetchedIngredientsByRecipeID? {
        
        
        
        guard let url = try UrlComponentsData.fetchRecipesIngredientsById(id: id).getUrl() else {throw URLError(.badURL)}
        
        
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
        
        
        guard let url = try UrlComponentsData.fetchRecipeIntsructions(id: id).getUrl() else {throw URLError(.badURL)}
        
        
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
        
        
        guard let url = try UrlComponentsData.fetchRecipeDatabyIngredients(
            ingredients: ingredients
        ).getUrl() else {throw URLError(.badURL)}
        
        
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
