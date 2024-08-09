//
//  APIManager .swift
//  CookBook
//
//  Created by Manu on 2024-08-07.
//

import Foundation


fileprivate func makeurlComponents(endpoint: API_ENDPOINTS) -> URLComponents? {
    
    guard var urlComponents = URLComponents(
        string: endpoint.url) else {
        return nil
    }
    
    return urlComponents
}

//MARK: APIManager
/// responsible for handling all api related calles (for example: recipe api)
class APIManager {
    
    // MARK: Fetch Recipe Infp
    func fetchRecipesInfo(query: String,
                          numberOfRes: Int,
                          searchMethod: SearchMethods) async throws -> FetchedItem
    
    {
        guard let apiKey = GetAPIKey.getAPIKey() else {throw URLError(.badURL)}

        
        guard var urlComponents = makeurlComponents(
            endpoint: API_ENDPOINTS.GET_RECIPE_INFO
        ) else {throw URLError(.badURL)}
        
        var urlQueryItems: [URLQueryItem]
        
        //How we wanna search
        if searchMethod == .SearchByName {
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                URLQueryItem(name: "addRecipeInformation", value: "True"),
                URLQueryItem(name: "titleMatch", value: query),
                URLQueryItem(name: "instructionsRequired", value: "true")
                
            ]
            
        }else{
            urlQueryItems = [
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "titleMatch", value: query),
                URLQueryItem(name: "number", value: "\(numberOfRes)"),
                
                
            ]
        }
        
        
        urlComponents.queryItems = urlQueryItems
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, res) = try await URLSession.shared.data(from: url)
        
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
        
         guard var urlComponents = makeurlComponents(
            endpoint: API_ENDPOINTS.GET_INGREDIENTS_BY_RECIPE_ID(id: id)
         ) else {throw URLError(.badURL)}
                

        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),

        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
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
        
        guard var urlComponents = makeurlComponents(
            endpoint: API_ENDPOINTS.GET_INSTRUCTIONS(id: id)
        ) else {throw URLError(.badURL)}
        
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, res) = try await URLSession.shared.data(
            from: url
        )
        
        guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200  else {
            throw URLError(.badServerResponse)
            
        }
        
        let fetchedIngredientsData = try JSONDecoder().decode([RecipeInstrcutions].self, from: data)
        
        return fetchedIngredientsData
    }
}
