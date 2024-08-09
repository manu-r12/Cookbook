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

class APIManager {
    

    
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
    
    func fetchInstructionsForARecipe(id: Int) async throws -> FetchedIngredientsByRecipeID? {
        
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
        
        let fetchedIngredientsData = try JSONDecoder().decode(FetchedIngredientsByRecipeID.self, from: data)
        
        return fetchedIngredientsData
    }
}
